import lustre
import lustre/attribute
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
    sketch.font_size(size.rem(2.0)),
    // Larger text for block titles
    sketch.font_weight("bold"),
    // Makes the title bold
    sketch.margin_("0 0 1.5rem 0"),
    // Adds spacing below the title
    sketch.color("#F7F7F7"),
    // Caribbean Current for title text
    sketch.text_align("center"),
    // Centers the text
    sketch.text_transform("uppercase"),
    // Makes the title uppercase
    sketch.letter_spacing("0.1rem"),
    // Adds spacing between letters for style
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
    sketch.background_color("#001524"),
    // Isabelline background
    sketch.border_radius(size.rem(1.0)),
    sketch.box_shadow("0 8px 16px rgba(0, 0, 0, 0.1)"),
    // Stronger shadow for depth
  ])
}

fn kanban_board_container() {
  sketch.class([
    sketch.overflow_x("auto"),
    // Enables horizontal scrolling
    sketch.white_space("nowrap"),
    // Prevents wrapping of blocks
    sketch.padding(size.rem(1.5)),
    // Adds padding around the scrolling area
    sketch.width(size.percent(100)),
  ])
}

fn kanban_board() {
  sketch.class([
    sketch.display("flex"),
    sketch.flex_direction("row"),
    sketch.gap(size.rem(2.5)),
    // Space between kanban blocks
  ])
}

fn kanban_block() {
  sketch.class([
    sketch.background_color("#2A3D45"),
    // Bright white background for blocks
    sketch.padding(size.rem(2.0)),
    // Padding for content
    sketch.width(size.rem(22.0)),
    // Fixed width for blocks
    sketch.flex_shrink(0.0),
    // Prevents shrinking in flex
    sketch.border_radius(size.rem(0.8)),
    // Rounded corners
    sketch.box_shadow("0 4px 8px rgba(0,0,0,0.1)"),
    // Subtle shadow
    sketch.display("flex"),
    sketch.flex_direction("column"),
    sketch.gap(size.rem(1.5)),
    // Space between tasks inside the block
    sketch.hover([sketch.box_shadow("0 6px 12px rgba(0,0,0,0.15)")]),
  ])
}

fn task() {
  sketch.class([
    sketch.text_align("center"),
    sketch.font_size(size.rem(1.5)),
    sketch.background_color("#F7F7F7"),
    // Sky Blue for task background
    sketch.border("0.1rem solid #ddd"),
    // Subtle border
    sketch.border_radius(size.rem(0.4)),
    // Rounded corners
    sketch.padding(size.rem(1.0)),
    // Padding inside the task
    sketch.margin_("0.5rem 0"),
    // Space between tasks
    sketch.box_shadow("0 1px 3px rgba(0,0,0,0.1)"),
    // Subtle shadow
    sketch.transition("transform 0.2s ease, box-shadow 0.2s ease"),
    // Smooth hover effect
    sketch.hover([
      sketch.transform("scale(1.02)"),
      // Slight grow on hover
      sketch.box_shadow("0 6px 12px rgba(0,0,0,0.2)"),
      // Prominent shadow on hover
    ]),
  ])
}

fn add_task_button() {
  sketch.class([
    sketch.background_color("#4B8F6A"),
    sketch.font_size(size.rem(1.5)),
    sketch.color("#fff"),
    sketch.border("none"),
    sketch.border_radius(size.rem(0.4)),
    sketch.padding(size.rem(0.8)),
    sketch.margin_("0.5rem 0"),
    sketch.text_align("center"),
    sketch.font_weight("bold"),
    sketch.cursor("pointer"),
    sketch.transition("transform 0.2s ease, background-color 0.2s ease"),
    sketch.hover([
      sketch.background_color("#4B8F8C"),
      sketch.transform("scale(1.05)"),
    ]),
  ])
}

fn add_task_input() {
  sketch.class([
    sketch.background_color("#F7F7F7"),
    // White background for input
    sketch.border("0.1rem solid #ccc"),
    // Subtle border
    sketch.border_radius(size.rem(0.4)),
    sketch.padding(size.rem(0.8)),
    sketch.margin_("0.5rem 0"),
    // Spacing around the input
    sketch.box_shadow("0 1px 3px rgba(0,0,0,0.1)"),
    // Subtle shadow
    sketch.font_size(size.rem(1.5)),
    // Standardized font size
  ])
}

fn view(_model: Model) {
  html.div(container(), [], [
    html.div(kanban_board_container(), [], [
      html.div(kanban_board(), [], [
        html.div(kanban_block(), [], [
          html.div(block_title(), [], [html.text("To Do")]),
          html.input(add_task_input(), [attribute.type_("text")]),
          html.button(add_task_button(), [], [html.text("Add Task")]),
          html.div(task(), [], [html.text("Do Homework")]),
          html.div(task(), [], [html.text("Prepare Presentation")]),
        ]),
        html.div(kanban_block(), [], [
          html.div(block_title(), [], [html.text("In Progress")]),
          html.input(add_task_input(), [attribute.type_("text")]),
          html.button(add_task_button(), [], [html.text("Add Task")]),
          html.div(task(), [], [html.text("Writing Code")]),
          html.div(task(), [], [html.text("Doing Sport")]),
        ]),
        html.div(kanban_block(), [], [
          html.div(block_title(), [], [html.text("Done")]),
          html.input(add_task_input(), [attribute.type_("text")]),
          html.button(add_task_button(), [], [html.text("Add Task")]),
          html.div(task(), [], [html.text("Finished Group Project")]),
          html.div(task(), [], [html.text("Completed Reading")]),
        ]),
      ]),
    ]),
  ])
}
