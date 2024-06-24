import app/router
import app/web.{Context}
import dot_env as dot
import dot_env/env
import gleam/erlang/process
import gleam/io
import mist
import wisp

pub fn main() {
  wisp.configure_logger()

  dot.new()
  |> dot.load()

  let assert Ok(secret_key_base) = env.get("SECRET_KEY_BASE")

  let ctx = Context(static_directory: get_static_directory(), items: [])

  let handler = router.handle_request(_, ctx)

  let assert Ok(_) =
    // arg1 is the request handler. arg2 is the secret key that we will use to sign cookies and other sensitive data.
    wisp.mist_handler(handler, secret_key_base)
    |> mist.new
    // pipe the handler to mist to start a new web server on port 8000
    |> mist.port(8000)
    |> mist.start_http

  io.println("Hello from app!")
  process.sleep_forever()
  // suspend the main process to keep the web server running
}

fn get_static_directory() {
  let assert Ok(priv_directory) = wisp.priv_directory("app")
  priv_directory <> "/static"
}
