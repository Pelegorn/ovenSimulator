function logFileGenerator(logMessage)
%LOGFILEGENERATOR Simple text logger for software statistics
%
%   input:
%   logMessage: Message to log into log-file.

fid = fopen('mangoSimulator_logFile.txt', 'a');
if fid == -1
  msgbox('log file error');
end
fprintf(fid, '%s: %s\n', datestr(now, 0), logMessage);
fclose(fid);
end