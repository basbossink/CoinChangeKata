# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
# 
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# 
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
require 'uri'
require 'open3'
command = "c:/Program Files (x86)/full phat/Snarl/tools/heysnarl.exe"
output = ""
args = ""
watch('(.*\.scm)$') { |md| 
    files = Dir.glob(File.join(File.dirname(__FILE__),"*.scm"))
    args = files.sort { |x,y| y.casecmp(x) } + ["-b", "-q", "-r5rs-syntax", "-n" ]
    stdin, stdout, stderr = Open3.popen3(
        "c:/chicken/bin/csi.exe",
        *args) 
    output = stdout.readlines[1..-3]
    err = stderr.readlines
    if err.length == 0 
        puts output
    else 
        puts "Out: %s\nErr: %s" % [output, err.join]
    end
    if output.to_s =~ /\(100%\) tests? passed/
        icon = "#{ENV["HOME"]}\\icons\\ok-icon.png"
    else
        icon = "#{ENV["HOME"]}\\icons\\Button-Close-icon.png"
    end
    args = if not(output) || output.empty?
                URI.escape(err[0..1].join).gsub(/%0A/,'\n')
            else 
                URI.escape(output[-1]).gsub(/%0A/,'\n')
            end
    args = "notify?title=" + 
        "Watchr: Scheme Tests" +
        "&text=" + 
        args +
        "&icon=" +
        icon
    stdin, stdout, stderr = Open3.popen3(command,args)
    puts(stderr.read)
}
