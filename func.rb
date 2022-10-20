require 'fileutils'

class Func < Formula
  v = "v1.8.0"
  plugin_name = "func"
  path_name = "#{plugin_name}"
  file_name = "#{plugin_name}"
  base_url = "https://github.com/knative/#{path_name}/releases/download/knative-#{v}"

  homepage "https://github.com/knative/#{path_name}"

  version v

  if OS.mac?
    if `uname -m`.chomp  == "arm64"
      url "#{base_url}/#{file_name}_darwin_arm64"
      sha256 "1f92f2804f0fda88f7c9511bb426fe6ca53c7336da89c3ef2d9d0f20118f9d35"
    else
      url "#{base_url}/#{file_name}_darwin_amd64"
      sha256 "75154d7764a7c6b13a1422b2cafb070260f46db2e885a83d8332d46dc3d8511c"
    end
  end

  if OS.linux?
    if `uname -m`.chomp  == "arm64"
      url "#{base_url}/#{file_name}_linux_arm64"
      sha256 "c76fcb927fc409ca851e9d113d2f1dcd1f282988d9ef3def44266a317eb58a7c"
    else
      url "#{base_url}/#{file_name}_linux_amd64"
      sha256 "7c6f24b1a6475745851dfa21bb93df1f66a82d103c6e113497dd167dc0f84185"
    end 
  end

  def install
    if OS.mac?
      if `uname -m`.chomp == "arm64"
        FileUtils.mv("func_darwin_arm64", "kn-func")
      else
        FileUtils.mv("func_darwin_amd64", "kn-func")
      end
    end
    if OS.linux?
      if `uname -m`.chomp == "arm64"
        FileUtils.mv("func_linux_arm64", "kn-func")
      else  
        FileUtils.mv("func_linux_amd64", "kn-func")
      end  
    end
    p "Installing kn-func binary in " + bin
    bin.install "kn-func"
    p "Installing func symlink in " + bin
    ln_s "kn-func", bin/"func"
  end

  test do
    system "#{bin}/kn-func", "version"
  end
end

