% Define the cutoff frequency and filter order
cutoff_frequency = 100; % Replace with your desired cutoff frequency in Hz (for high-pass filter)
filter_order = 4; % Replace with your desired filter order (e.g., 2, 4, 6, ...)

% Generate a sample signal for demonstration purposes
fs = 10000; % Sampling frequency in Hz
t = 0:1/fs:1; % Time vector
signal = sin(2*pi*50*t) + 0.5*sin(2*pi*120*t) + 0.2*sin(2*pi*60*t); % Example signal with multiple frequencies

% Design the high-pass Butterworth filter
normalized_cutoff_freq = cutoff_frequency / (0.5 * fs);
[b, a] = butter(filter_order, normalized_cutoff_freq, 'high'); % Change 'low' to 'high'

% Apply the filter to the signal using filtfilt to avoid phase distortion
filtered_signal = filtfilt(b, a, signal);

% Plot the original and filtered signals
figure;
subplot(2,1,1);
plot(t, signal);
title('Original Signal');
xlabel('Time (s)');
ylabel('Amplitude');

subplot(2,1,2);
plot(t, filtered_signal);
title('Filtered Signal (High-Pass)');
xlabel('Time (s)');
ylabel('Amplitude');

% Display the frequency response of the filter (optional)
frequencies = 0:1:fs/2;
H = freqz(b, a, frequencies, fs);
figure;
plot(frequencies, 20*log10(abs(H)));
title('Frequency Response of the High-Pass Filter');
xlabel('Frequency (Hz)');
ylabel('Magnitude (dB)');
grid on;
