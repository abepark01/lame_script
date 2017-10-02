require 'fileutils'
require 'active_support/core_ext/object/blank'

path = ".\\source\\"
audio_file = "Audio Files\\Take00.wav"
processed_path = ".\\processed\\"
output_path = ".\\output"
lame_path = "\"C:\\Program Files (x86)\\Lame For Audacity\\lame.exe\""
cmd = "#{lame_path} -b 64 -h -a \"{source_path}\\#{audio_file}\" \"#{output_path}\\{item}.mp3\""


Dir.foreach(path) do |item|
  next if item == "." or item == ".."
  if File.directory?(path + item)
    run_cmd = String.new(cmd)
    run_cmd["{source_path}"] = path + item
    run_cmd["{item}"] = item

    unless File.directory?(output_path + item)
      FileUtils.mkdir_p(output_path + item)
    end
    puts run_cmd
    exit_code = `#{run_cmd}`

    if exit_code.blank?
      FileUtils.mv(path + item, processed_path + item)
    end

  end
end
