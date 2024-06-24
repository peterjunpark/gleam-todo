import app/web.{type Context}
import gleam/string_builder
import wisp.{type Request, type Response}

pub fn handle_request(req: Request, ctx: Context) -> Response {
  wisp.html_response(string_builder.from_string("Hello world!"), 200)
}
