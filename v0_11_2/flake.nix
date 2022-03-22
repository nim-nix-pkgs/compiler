{
  description = ''Compiler package providing the compiler sources as a library.'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs.src-compiler-v0_11_2.flake = false;
  inputs.src-compiler-v0_11_2.owner = "nim-lang";
  inputs.src-compiler-v0_11_2.ref   = "v0_11_2";
  inputs.src-compiler-v0_11_2.repo  = "Nim.git";
  inputs.src-compiler-v0_11_2.type  = "github";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@deps:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib" "src-compiler-v0_11_2"];
  in lib.mkRefOutput {
    inherit self nixpkgs ;
    src  = deps."src-compiler-v0_11_2";
    deps = builtins.removeAttrs deps args;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
  };
}