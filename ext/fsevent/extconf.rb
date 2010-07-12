if `uname -s`.chomp == 'Darwin'
  # Workaround to make Rubygems believe it builds a native gem
  def emulate_extension_install(extension_name)
    File.open('Makefile', 'w') { |f| f.write "all:\n\ninstall:\n\n" }
    File.open('make', 'w') do |f|
      f.write '#!/bin/sh'
      f.chmod f.stat.mode | 0111
    end
    File.open(extension_name + '.so', 'w') {}
    File.open(extension_name + '.dll', 'w') {}
    File.open('nmake.bat', 'w') { |f| }
  end
  
  emulate_extension_install('fsevent')
  
  gem_root      = File.expand_path(File.join('..', '..'))
  darwin_verion = `uname -r`.to_i
  sdk_verion    = { 9 => '10.5', 10 => '10.6', 11 => '10.7' }[darwin_verion]
  
  raise "Darwin #{darwin_verion} is not supported" unless sdk_verion
  
  # Compile the actual fsevent_watch binary
  system("CFLAGS='-isysroot /Developer/SDKs/MacOSX#{sdk_verion}.sdk -mmacosx-version-min=#{sdk_verion}' /usr/bin/gcc -framework CoreServices -o '#{gem_root}/bin/fsevent_watch' fsevent_watch.c")
  
  unless File.executable?("#{gem_root}/bin/fsevent_watch")
    raise "Compilation of fsevent_watch failed (see README)"
  end
end