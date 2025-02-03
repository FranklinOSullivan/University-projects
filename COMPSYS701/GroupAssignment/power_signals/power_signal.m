% Parameters
f0 = 50;                 % Fundamental frequency (Hz)
w = 2 * pi * f0;         % Angular frequency of the first harmonic (rad/s)
fs = 16000;              % Sampling frequency (Hz)
n_bits = 12;              % Number of bits for quantization (can be 8, 10, or 12)
num_cycles = 5;          % Number of cycles to generate
T = 1 / f0;              % Period of the fundamental frequency (s)
num_samples = num_cycles * T * fs; % Total number of samples for 5 cycles
SNR_dB = 21;             % Signal-to-Noise Ratio in dB

% Time vector
t = (0:num_samples-1) / fs;

% Generate the power signal samples
v = 0.3 + 5 * sin(w * t + 2.5) + 1.5 * sin(3 * w * t + 1.3) + 0.75 * sin(5 * w * t + 1) + 0.375 * sin(7 * w * t + 0.6) + 0.1875 * sin(9 * w * t + 0.3);

% Add noise with specified SNR
signal_power = rms(v)^2;
noise_power = signal_power / (10^(SNR_dB / 10));
noise = sqrt(noise_power) * randn(size(v));
v_noisy = v + noise;

% Quantize the signal to n-bit unsigned integers
max_val = 2^n_bits - 1;
v_quantized = round((v_noisy - min(v_noisy)) / (max(v_noisy) - min(v_noisy)) * max_val);

% Ensure the values are within the range of unsigned integers
v_quantized(v_quantized < 0) = 0;
v_quantized(v_quantized > max_val) = max_val;

% Export to .mif file
mif_filename = sprintf('power_signal_%dbit_%dcycles.mif', n_bits, num_cycles);
fid = fopen(mif_filename, 'w');

% Write the .mif file header
fprintf(fid, 'DEPTH = %d;\n', num_samples);
fprintf(fid, 'WIDTH = %d;\n', n_bits);
fprintf(fid, 'ADDRESS_RADIX = HEX;\n');
fprintf(fid, 'DATA_RADIX = HEX;\n');
fprintf(fid, 'CONTENT BEGIN\n');

% Write the quantized data
for i = 1:num_samples
    fprintf(fid, '%X : %X;\n', i-1, v_quantized(i));
end

% Write the .mif file footer
fprintf(fid, 'END;\n');
fclose(fid);

% Plot the signal (optional)
figure;
subplot(2, 1, 1);
plot(t, v, '-b'); hold on;
plot(t, v_noisy, '-g'); 
stairs(t, (v_quantized / max_val) * (max(v_noisy) - min(v_noisy)) + min(v_noisy), '-r');
xlabel('Time (s)');
ylabel('Amplitude');
title(sprintf('Power Signal (%d-bit quantization)', n_bits));
legend('Original Signal', 'Noisy Signal', 'Quantized Signal');
grid on;

% Display information
disp(['Generated ' num2str(num_cycles) ' cycles of power signal with ' num2str(n_bits) '-bit quantization.']);
disp(['Samples saved to output file']);
