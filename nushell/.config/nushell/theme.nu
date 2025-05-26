let flexoki_black = "#100F0F"
let flexoki_paper = "#FFFCF0"

let flexoki_50 = "#F2F0E5"
let flexoki_100 = "#E6E4D9"
let flexoki_150 = "#DAD8CE"
let flexoki_200 = "#CECDC3"
let flexoki_300 = "#B7B5AC"
let flexoki_400 = "#9F9D96"
let flexoki_500 = "#878580"
let flexoki_600 = "#6F6E69"
let flexoki_700 = "#575653"
let flexoki_800 = "#403E3C"
let flexoki_850 = "#343331"
let flexoki_900 = "#282726"
let flexoki_950 = "#1C1B1A"

let flexoki_red_50 = "#FFE1D5"
let flexoki_red_100 = "#FFCABB"
let flexoki_red_150 = "#FDB2A2"
let flexoki_red_200 = "#F89A8A"
let flexoki_red_300 = "#E8705F"
let flexoki_red_400 = "#D14D41"
let flexoki_red_500 = "#C03E35"
let flexoki_red_600 = "#AF3029"
let flexoki_red_700 = "#942822"
let flexoki_red_800 = "#6C201C"
let flexoki_red_850 = "#551B18"
let flexoki_red_900 = "#3E1715"
let flexoki_red_950 = "#261312"

let flexoki_orange_50 = "#FFE7CE"
let flexoki_orange_100 = "#FED3AF"
let flexoki_orange_150 = "#FCC192"
let flexoki_orange_200 = "#F9AE77"
let flexoki_orange_300 = "#EC8B49"
let flexoki_orange_400 = "#DA702C"
let flexoki_orange_500 = "#CB6120"
let flexoki_orange_600 = "#BC5215"
let flexoki_orange_700 = "#9D4310"
let flexoki_orange_800 = "#71320D"
let flexoki_orange_850 = "#59290D"
let flexoki_orange_900 = "#40200D"
let flexoki_orange_950 = "#27180E"

let flexoki_yellow_50 = "#FAEEC6"
let flexoki_yellow_100 = "#F6E2A0"
let flexoki_yellow_150 = "#F1D67E"
let flexoki_yellow_200 = "#ECCB60"
let flexoki_yellow_300 = "#DFB431"
let flexoki_yellow_400 = "#D0A215"
let flexoki_yellow_500 = "#BE9207"
let flexoki_yellow_600 = "#AD8301"
let flexoki_yellow_700 = "#8E6B01"
let flexoki_yellow_800 = "#664D01"
let flexoki_yellow_850 = "#503D02"
let flexoki_yellow_900 = "#3A2D04"
let flexoki_yellow_950 = "#241E08"

let flexoki_green_50 = "#EDEECF"
let flexoki_green_100 = "#DDE2B2"
let flexoki_green_150 = "#CDD597"
let flexoki_green_200 = "#BEC97E"
let flexoki_green_300 = "#A0AF54"
let flexoki_green_400 = "#879A39"
let flexoki_green_500 = "#768D21"
let flexoki_green_600 = "#66800B"
let flexoki_green_700 = "#536907"
let flexoki_green_800 = "#3D4C07"
let flexoki_green_850 = "#313D07"
let flexoki_green_900 = "#252D09"
let flexoki_green_950 = "#1A1E0C"

let flexoki_cyan_50 = "#DDF1E4"
let flexoki_cyan_100 = "#BFE8D9"
let flexoki_cyan_150 = "#A2DECE"
let flexoki_cyan_200 = "#87D3C3"
let flexoki_cyan_300 = "#5ABDAC"
let flexoki_cyan_400 = "#3AA99F"
let flexoki_cyan_500 = "#2F968D"
let flexoki_cyan_600 = "#24837B"
let flexoki_cyan_700 = "#1C6C66"
let flexoki_cyan_800 = "#164F4A"
let flexoki_cyan_850 = "#143F3C"
let flexoki_cyan_900 = "#122F2C"
let flexoki_cyan_950 = "#101F1D"

let flexoki_blue_50 = "#E1ECEB"
let flexoki_blue_100 = "#C6DDE8"
let flexoki_blue_150 = "#ABCFE2"
let flexoki_blue_200 = "#92BFDB"
let flexoki_blue_300 = "#66A0C8"
let flexoki_blue_400 = "#4385BE"
let flexoki_blue_500 = "#3171B2"
let flexoki_blue_600 = "#205EA6"
let flexoki_blue_700 = "#1A4F8C"
let flexoki_blue_800 = "#163B66"
let flexoki_blue_850 = "#133051"
let flexoki_blue_900 = "#12253B"
let flexoki_blue_950 = "#101A24"

let flexoki_purple_50 = "#F0EAEC"
let flexoki_purple_100 = "#E2D9E9"
let flexoki_purple_150 = "#D3CAE6"
let flexoki_purple_200 = "#C4B9E0"
let flexoki_purple_300 = "#A699D0"
let flexoki_purple_400 = "#8B7EC8"
let flexoki_purple_500 = "#735EB5"
let flexoki_purple_600 = "#5E409D"
let flexoki_purple_700 = "#4F3685"
let flexoki_purple_800 = "#3C2A62"
let flexoki_purple_850 = "#31234E"
let flexoki_purple_900 = "#261C39"
let flexoki_purple_950 = "#1A1623"

let flexoki_magenta_50 = "#FEE4E5"
let flexoki_magenta_100 = "#FCCFDA"
let flexoki_magenta_150 = "#F9B9CF"
let flexoki_magenta_200 = "#F4A4C2"
let flexoki_magenta_300 = "#E47DA8"
let flexoki_magenta_400 = "#CE5D97"
let flexoki_magenta_500 = "#B74583"
let flexoki_magenta_600 = "#A02F6F"
let flexoki_magenta_700 = "#87285E"
let flexoki_magenta_800 = "#641F46"
let flexoki_magenta_850 = "#4F1B39"
let flexoki_magenta_900 = "#39172B"
let flexoki_magenta_950 = "#24131D"


# Define the Flexoki dark theme for Nushell
let flexoki_dark = {
  separator: $flexoki_700

  # Leading/trailing spaces are highlighted with the background color for contrast
  leading_trailing_space_bg: $flexoki_black

  # The header is emphasized in bold blue
  header: { fg: $flexoki_green_400, attr: b }

  # Empty cells are shown in a magenta tone
  empty: $flexoki_paper

  # Row indexes use bold green for better readability
  row_index: { fg: $flexoki_green_400, attr: b }

  # Hints remain set to a default dark gray (you can change this value if preferred)
  hints: "dark_gray"

  # Date values are rendered in cyan
  date: $flexoki_cyan_400

  # Filesize values use orange for visibility
  filesize: $flexoki_orange_400

  # Boolean values and binary-related outputs are indicated in red
  bool: $flexoki_red_400
  binary: $flexoki_red_400
  nothing: $flexoki_red_400

  # Integer values are given a green tone
  int: $flexoki_green_400

  # Duration values are highlighted in red to match boolean indicators
  duration: $flexoki_red_400

  # Ranges are colored in orange
  range: $flexoki_orange_400

  # Floating point numbers take on a yellow color
  float: $flexoki_yellow_400

  # Strings use a magenta hue for consistency with empty cells
  string: $flexoki_magenta_400

  # Cell paths are rendered in cyan
  cellpath: $flexoki_cyan_400
}

