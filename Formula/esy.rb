class Esy < Formula
    desc "Native package.json workflow for Reason/OCaml"
    homepage "https://esy.sh"
    url "https://registry.npmjs.org/esy/-/esy-0.5.8.tgz"
    sha256 "f2cec5e6556172141bb399d1dcef7db4b9d881b0bed9c9749c0eebd95584b739"
    version "0.5.8"
  
    resource "esy-solve-cudf" do
      url "https://registry.npmjs.org/esy-solve-cudf/-/esy-solve-cudf-0.1.10.tgz"
      sha256 "3cfb233e5536fe555ff1318bcff241481c8dcbe1edc30b5f97e2366134d3f234"
    end
  
    def install
      mkdir_p prefix/"lib"
      mkdir_p prefix/"bin"

      cp_r "package.json", prefix
      cp_r "platform-darwin/_build/default/bin/esyInstallRelease.js", prefix/"bin"
      cp_r "platform-darwin/_build/default/", prefix/"lib"
      ln_s prefix/"lib/default/bin/esy.exe", prefix/"bin/esy"
      chmod 0555, prefix/"lib/default/bin/esyCommand.exe"
      chmod 0555, prefix/"lib/default/esy-build-package/bin/esyBuildPackageCommand.exe"
      chmod 0555, prefix/"lib/default/esy-build-package/bin/esyRewritePrefixCommand.exe"
  
      # install esy-solve-cudf
      esy_solve_cudf_build = buildpath/"esySolveCudf"
      esy_solve_cudf_install = prefix/"lib/node_modules/esy-solve-cudf"
  
      esy_solve_cudf_build.install resource("esy-solve-cudf")
      mkdir_p esy_solve_cudf_install
  
      cp_r esy_solve_cudf_build/"platform-darwin/esySolveCudfCommand.exe", esy_solve_cudf_install
      cp_r esy_solve_cudf_build/"package.json", esy_solve_cudf_install
    end
  
    test do
      assert_equal "0.5.8", shell_output("#{bin}/esy --version").strip
    end
  end
