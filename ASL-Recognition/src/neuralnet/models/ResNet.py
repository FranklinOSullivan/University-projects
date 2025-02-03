from torch.nn import Conv2d, Sequential, Module, BatchNorm2d, ReLU, MaxPool2d, Linear, AvgPool2d


class ResNet(Module):
    # Scaled down ResNet model for MNIST data
    def __init__(self):
        super(ResNet, self).__init__()
        block = ResidualBlock
        layers = [3, 4, 6, 3]
        self.inplanes = 32
        self.conv1 = Sequential(
            Conv2d(1, 32, kernel_size=7, stride=2, padding=3),
            BatchNorm2d(32),
            ReLU())
        self.maxpool = MaxPool2d(kernel_size=3, stride=2, padding=1)
        self.layer0 = self._make_layer(block, 32, layers[0], stride=1)
        self.layer1 = self._make_layer(block, 64, layers[1], stride=2)
        self.layer2 = self._make_layer(block, 128, layers[2], stride=2)
        self.layer3 = self._make_layer(block, 256, layers[3], stride=1)
        self.avgpool = AvgPool2d(2, stride=1)
        self.fc = Linear(256, 26)

    def _make_layer(self, block, planes, blocks, stride=1):
        downsample = None
        if stride != 1 or self.inplanes != planes:

            downsample = Sequential(
                Conv2d(self.inplanes, planes, kernel_size=1, stride=stride),
                BatchNorm2d(planes),
            )
        layers = []
        layers.append(block(self.inplanes, planes, stride, downsample))
        self.inplanes = planes
        for i in range(1, blocks):
            layers.append(block(self.inplanes, planes))

        return Sequential(*layers)

    def forward(self, x):
        x = self.conv1(x)
        x = self.maxpool(x)
        x = self.layer0(x)
        x = self.layer1(x)
        x = self.layer2(x)
        x = self.layer3(x)

        x = self.avgpool(x)
        x = x.view(x.size(0), -1)
        x = self.fc(x)

        return x


class ResidualBlock(Module):
    def __init__(self, in_channels, out_channels, stride=1, downsample=None):
        super(ResidualBlock, self).__init__()
        self.conv1 = Sequential(
            Conv2d(in_channels, out_channels,
                   kernel_size=3, stride=stride, padding=1),
            BatchNorm2d(out_channels),
            ReLU())
        self.conv2 = Sequential(
            Conv2d(out_channels, out_channels,
                   kernel_size=3, stride=1, padding=1),
            BatchNorm2d(out_channels))
        self.downsample = downsample
        self.relu = ReLU()
        self.out_channels = out_channels

    def forward(self, x):
        residual = x
        out = self.conv1(x)
        out = self.conv2(out)
        if self.downsample:
            residual = self.downsample(x)
        out += residual
        out = self.relu(out)
        return out
