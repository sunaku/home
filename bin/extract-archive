#!/usr/bin/env ruby
#
# Extracts various compressed and uncompressed file archives (see
# http://en.wikipedia.org/wiki/List_of_archive_formats) into their
# *own* output directories so that they do not make a mess by
# extracting directly into your working directory.
#
# Written in 2003 by Suraj N. Kurapati <https://github.com/sunaku>

require 'tmpdir'

require 'fileutils'
include FileUtils::Verbose

# Extracts the given source archive relative to the given destination path,
# and returns the path of the directory containing the extracted contents.
def extract src_path, dst_path = File.dirname(src_path)
  src_path = File.expand_path(src_path)
  src_name = File.basename(src_path)
  src_suffix = File.extname(src_name)
  src_prefix = File.basename(src_name, src_suffix)

  Dir.mktmpdir(nil, dst_path) do |tmp_dir|
    # decompress the archive
    cd tmp_dir do
      case src_name.sub(/\.part$/, '')
      when /\.(tar\.gz|tar\.Z|tgz|taz)$/i
        system 'tar', '-zxf', src_path

      when /\.(tar\.bz|tar\.bz2|tbz|tbz2)$/i
        system 'tar', '-jxf', src_path

      when /\.(tar\.xz|txz)$/i
        system 'tar', '-Jxf', src_path

      when /\.(tar|cpio|gem)$/i
        system 'tar', '-xf', src_path

      when /\.(tar.lzo|tzo)$/i
        system "lzop -xc #{src_path.inspect} | tar -xf -"

      when /\.(lzo)$/i
        system 'lzop', '-x', src_path

      when /\.(gz)$/i
        system "gunzip -c #{src_path.inspect} > #{src_prefix.inspect}"

      when /\.(bz|bz2)$/i
        system "bunzip2 -c #{src_path.inspect} > #{src_prefix.inspect}"

      when /\.(shar)$/i
        system 'sh', src_path

      when /\.(7z)$/i
        system '7zr', 'x', src_path

      when /\.(zip)$/i
        system 'unzip', src_path

      when /\.(jar)$/i
        system 'jar', 'xf', src_path

      when /\.(rz)$/i
        ln src_path, src_name # rzip removes the archive after extraction
        system 'rzip', '-d', src_name

      when /\.(rar)$/i
        system 'unrar', 'x', src_path

      when /\.(ace)$/i
        system 'unace', 'x', src_path

      when /\.(arj)$/i
        system 'arj', 'x', src_path

      when /\.(arc)$/i
        system 'arc', 'x', src_path

      when /\.(lhz|lha)$/i
        system 'lha', 'x', src_path

      when /\.(a|ar)$/i
        system 'ar', '-x', src_path

      when /\.(Z)$/
        system "uncompress -c #{src_path.inspect} > #{src_prefix.inspect}"

      when /\.(z)$/
        system "pcat #{src_path.inspect} > #{src_prefix.inspect}"

      when /\.(zoo)$/i
        system 'zoo', 'x//', src_path

      when /\.(cab)$/i
        system 'cabextract', src_path

      when /\.(deb)$/i
        system 'ar', 'x', src_path

      when /\.(rpm)$/i
        system "rpm2cpio #{src_path.inspect} | cpio -i --make-directories"

      else
        warn "I do not know how to extract #{src_path.inspect}"
      end
    end

    # clean any mess made by decompression
    manifest = Dir.new(tmp_dir).entries - %w[ . .. ]

    if manifest.length == 1 # there was no mess!
      adj_dst = File.join(dst_path, manifest.first)
      adj_src = File.join(tmp_dir, manifest.first)
    else
      adj_src = tmp_dir
      adj_dst = File.join(dst_path, src_name[/.*(?=\..*?)/])
    end

    adj_dst << "+#{Time.now.to_i}" until
      not File.exist? adj_dst and
      mv(adj_src, adj_dst, :force => true)

    touch tmp_dir # give Dir.mktmpdir() something to remove

    adj_dst
  end
end

if $0 == __FILE__
  prefix = File.basename(__FILE__)

  ARGV.each do |src|
    dst = extract(src)
    puts "#{prefix}: '#{src}' => '#{dst}'"
  end
end
