# Detection
# ‾‾‾‾‾‾‾‾‾

hook global BufCreate .*[.](cs) %{
  set-option buffer filetype csharp
}

hook global BufCreate .*[.](csproj) %{
  set-option buffer filetype xml
}

hook global BufCreate .*[.](sln) %{
  set-option buffer filetype xml
}

# Initialization
# ‾‾‾‾‾‾‾‾‾‾‾‾‾‾

hook global WinSetOption filetype=csharp %{
  require-module csharp

  hook -once -always window WinSetOption filetype=.* %{ remove-hooks window csharp-.+ }
}

hook -group csharp-highlight global WinSetOption filetype=csharp %{
  add-highlighter window/csharp ref csharp
  hook -once -always window WinSetOption filetype=.* %{ remove-highlighter window/csharp }
}

provide-module csharp %§

# Highlighting and hooks bulder for C#
# ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾

add-highlighter "shared/csharp"               regions
add-highlighter "shared/csharp/code"          default-region group
add-highlighter "shared/csharp/shebang"       region ^#!  $                       fill meta
add-highlighter "shared/csharp/double_string" region '"'  (?<!\\)(\\\\)*"         fill string
add-highlighter "shared/csharp/comment_line"  region //   '$'                     fill comment
add-highlighter "shared/csharp/comment"       region /\*  \*/                     fill comment
add-highlighter shared/csharp/code/ regex %{\b(this|true|false|null)\b} 0:value
add-highlighter shared/csharp/code/ regex "\b(void|int|char|decimal|boolean|double|float)\b" 0:type
add-highlighter shared/csharp/code/ regex "\b(while|for|if|else|do|static|switch|case|default|class|interface|enum|break|continue|return|using|namespace|try|catch|throw|new|extends|implements|throws|instanceof|finally|as)\b" 0:keyword
add-highlighter shared/csharp/code/ regex "\b(final|public|protected|private|abstract)\b" 0:attribute

# Commands
# ‾‾‾‾‾‾‾‾

§
