# Documentation: https://docs.brew.sh/Formula-Cookbook
#                https://rubydoc.brew.sh/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!
class Esy < Formula
    desc "Native package.json workflow for Reason/OCaml"
    homepage "https://esy.sh"
    url "https://dev.azure.com/esy-dev/4b89787a-af2b-4e8a-bb58-87b268d428f3/_apis/build/builds/2024/artifacts?artifactName=Release&api-version=5.2-preview.5&%24format=zip"
    sha256 "774d1a6986f5fdb11e5fac18f73c61fdc4baa0cfc0f0a8c78f0afc1b416d8383"
    version "0.5.8"
  
    resource "esy-solve-cudf" do
      url "https://registry.npmjs.org/esy-solve-cudf/-/esy-solve-cudf-0.1.10.tgz"
      sha256 "3cfb233e5536fe555ff1318bcff241481c8dcbe1edc30b5f97e2366134d3f234"
    end
  
    def install
      mkdir_p prefix/"lib"
      mkdir_p prefix/"bin"

      cp_r "package.json", prefix
      cp_r "bin/esyInstallRelease.js", prefix/"bin"
      cp_r "platform-darwin/_build/default/", prefix/"lib"
      ln_s prefix/"lib/default/esy/bin/esyCommand.exe", prefix/"bin/esy"
      chmod 0555, prefix/"lib/default/esy/bin/esyCommand.exe"
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
