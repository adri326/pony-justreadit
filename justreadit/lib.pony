use "files"
use "collections"
use "debug"

primitive JustRead
  """
  # The JustRead primitive

  Simply call `JustRead.apply` to read a file. Note that it will just do that.

  Example:

  ```pony
  use "justread"

  actor Main
    let env: Env
    new create(env': Env) =>
      env = env'
      JustRead("file.txt", env, this~print_reverse())

    fun print_reverse(str: String) =>
      env.out.print(str.reverse())
  ```
  """
  fun apply(path: String, env: (Env | AmbientAuth), callback: {(String val): None}): Bool =>
    try
      let fpath = FilePath(
        match env
        | let env': Env => env'.root as AmbientAuth
        | let ambient_auth: AmbientAuth => ambient_auth
        end,
        path
      )?
      try
        if FileInfo(fpath)?.file then
          let file = File.open(fpath)
          let source = file.read_string(file.size())
          callback(consume source)
          true
        else
          match env
          | let env': Env => env'.out.print("File '" + path + "' doesn't exist or isn't a file!")
          else Debug("File '" + path + "' doesn't exist or isn't a file!")
          end
          false
        end
      else
        match env
        | let env': Env => env'.out.print("File '" + path + "' is not a valid path!")
        else Debug("File '" + path + "' is not a valid path!")
        end
        false
      end
    else
      match env
      | let env': Env => env'.out.print("Cannot access '" + path + "'; make sure to use an AmbientAuth-enabled Env")
      else Debug("Cannot access '" + path + "'; make sure to use an AmbientAuth-enabled Env")
      end
      false
    end
