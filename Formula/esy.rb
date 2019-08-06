# Documentation: https://docs.brew.sh/Formula-Cookbook
#                https://rubydoc.brew.sh/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!
class Esy < Formula
    desc "Native package.json workflow for Reason/OCaml"
    homepage "https://esy.sh"
    url "https://dev.azure.com/esy-dev/4b89787a-af2b-4e8a-bb58-87b268d428f3/_apis/build/builds/2024/artifacts?artifactName=platform-darwin&api-version=5.2-preview.5&%24format=zip"
    sha256 "002bc27d561fdf4cb3b118d3f190b889484af2c461cf08c1ac891378e5056dac"
    version "0.5.8"
  
    resource "esy-solve-cudf" do
      url "https://registry.npmjs.org/esy-solve-cudf/-/esy-solve-cudf-0.1.10.tgz"
      sha256 "3cfb233e5536fe555ff1318bcff241481c8dcbe1edc30b5f97e2366134d3f234"
    end
  
    def install
      mkdir_p prefix/"lib"
      mkdir_p prefix/"bin"
  
      cp_r "_build/default", prefix
  
      # install esy-solve-cudf
      esy_solve_cudf_build = buildpath/"esySolveCudf"
      esy_solve_cudf_install = prefix/"lib/node_modules/esy-solf-cudf"
  
      esy_solve_cudf_build.install resource("esy-solve-cudf")
      mkdir_p esy_solve_cudf_install
  
      cp_r esy_solve_cudf_build/"platform-darwin/esySolveCudfCommand.exe", esy_solve_cudf_install
      cp_r esy_solve_cudf_build/"package.json", esy_solve_cudf_install
    end
  
    test do
      assert_equal "0.5.8", shell_output("#{bin}/esy --version").strip
    end
  end
  