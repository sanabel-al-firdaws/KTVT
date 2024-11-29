import lustre
import lustre/effect.{type Effect}

import sketch/size

import sketch
import sketch/lustre as sketch_lustre
import sketch/lustre/element/html

// MAIN ------------------------------------------------------------------------

pub fn main() {
  let assert Ok(cache) = sketch.cache(strategy: sketch.Ephemeral)
  sketch_lustre.node()
  |> sketch_lustre.compose(view, cache)
  |> lustre.application(init, update, _)
  |> lustre.start("#app", Nil)
}

// MODEL -----------------------------------------------------------------------
type Model {
  Model(number: Int)
}

fn init(_flags) -> #(Model, Effect(Msg)) {
  #(Model(number: 0), effect.none())
}

// UPDATE ----------------------------------------------------------------------

pub opaque type Msg {
  Incr
  Decr
}

fn update(model: Model, msg: Msg) {
  case msg {
    Incr -> #(Model(model.number + 1), effect.none())
    Decr -> #(Model(model.number - 1), effect.none())
  }
}

// VIEW ------------------------------------------------------------------------
fn block_title() {
  sketch.class([
    sketch.font_size(size.rem(1.5)),
    // Larger text for block titles
    sketch.font_weight("bold"),
    // Makes the title bold
    sketch.margin_("0 0 1rem 0"),
    // Adds spacing below the title
    sketch.color("#333"),
    // Dark text color for readability
    sketch.text_align("center"),
    // Centers the text
  ])
}

fn container() {
  sketch.class([
    sketch.display("flex"),
    sketch.flex_direction("column"),
    sketch.align_items("center"),
    // Centers the content horizontally
    sketch.margin_("auto"),
    // Centers the container
    sketch.padding(size.rem(2.0)),
    // Padding inside the container
    sketch.width(size.percent(90)),
    // Responsive width
    sketch.max_width(size.rem(80.0)),
    // Maximum width for large screens
  ])
}

fn kanban_board_container() {
  sketch.class([
    sketch.overflow_x("auto"),
    // Enables horizontal scrolling
    sketch.white_space("nowrap"),
    // Prevents wrapping of blocks
    sketch.padding(size.rem(1.0)),
    // Adds padding around the scrolling area
    sketch.width(size.percent(100)),
    // Ensures the container spans full width
  ])
}

fn kanban_board() {
  sketch.class([
    sketch.display("flex"),
    sketch.flex_direction("row"),
    sketch.gap(size.rem(2.0)),
    // Space between kanban blocks
  ])
}

fn kanban_block() {
  sketch.class([
    sketch.background_color("#f8f9fa"),
    // Light background for blocks
    sketch.padding(size.rem(1.5)),
    // Padding for content
    sketch.width(size.rem(20.0)),
    // Fixed width for blocks
    sketch.flex_shrink(0.0),
    // Prevents shrinking in flex
    sketch.border_radius(size.rem(0.5)),
    // Rounded corners
    sketch.box_shadow("0 2px 6px rgba(0,0,0,0.1)"),
    // Subtle shadow
    sketch.display("flex"),
    sketch.flex_direction("column"),
    sketch.gap(size.rem(1.0)),
    // Space between tasks inside the block
  ])
}

fn task() {
  sketch.class([
    sketch.background_color("white"),
    // Bright background for tasks
    sketch.border("0.1rem solid #ddd"),
    // Subtle border
    sketch.border_radius(size.rem(0.3)),
    // Rounded corners
    sketch.padding(size.rem(1.0)),
    // Padding inside the task
    sketch.margin_("0.5rem 0"),
    // Space between tasks
    sketch.box_shadow("0 1px 3px rgba(0,0,0,0.1)"),
    // Subtle shadow
    sketch.transition("transform 0.2s ease"),
    // Smooth hover effect
    sketch.hover([
      sketch.transform("scale(1.02)"),
      // Slight grow on hover
      sketch.box_shadow("0 4px 6px rgba(0,0,0,0.2)"),
      // Prominent shadow on hover
    ]),
  ])
}

fn view(_model: Model) {
  html.div(container(), [], [
    html.div(kanban_board_container(), [], [
      html.div(kanban_board(), [], [
        html.div(kanban_block(), [], [
          html.div(block_title(), [], [html.text("To Do")]),
          html.div(task(), [], [html.text("Do Homework")]),
          html.div(task(), [], [html.text("Prepare Presentation")]),
          html.div(task(), [], [html.text("Do Homework")]),
          html.div(task(), [], [html.text("Prepare Presentation")]),
        ]),
        html.div(kanban_block(), [], [
          html.div(block_title(), [], [html.text("In Progress")]),
          html.div(task(), [], [html.text("Writing Code")]),
          html.div(task(), [], [html.text("Doing Sport")]),
          html.div(task(), [], [html.text("Do Homework")]),
          html.div(task(), [], [html.text("Prepare Presentation")]),
        ]),
        html.div(kanban_block(), [], [
          html.div(block_title(), [], [html.text("Done")]),
          html.div(task(), [], [html.text("Finished Group Project")]),
          html.div(task(), [], [html.text("Completed Reading")]),
          html.div(task(), [], [html.text("Do Homework")]),
          html.div(task(), [], [html.text("Prepare Presentation")]),
        ]),
      ]),
    ]),
  ])
}
