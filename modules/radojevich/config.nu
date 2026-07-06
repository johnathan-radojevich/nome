def gc [] {
    let ghostty_dir = ($env.HOME | path join ".config" "ghostty")

    let files = (
        ls $ghostty_dir
        | where type == file and ($it.name | path basename) != "config"
        | get name
    )

    let selection = (
        $files
        | each { |p| $p | path relative-to $ghostty_dir }
        | str join "\n"
        | fzf --preview $"cat ($ghostty_dir)/{}"
    )

    if ($selection | is-empty) {
        return
    }

    let config_file = ($ghostty_dir | path join "config")

    let content = (
        open $config_file
        | str replace -r '(config-file = [^/]+)/.*' $"$1/($selection)"
    )

    $content | save --force $config_file

    ^osascript -e 'tell application "Ghostty" to activate' `
               -e 'tell application "System Events" to keystroke "," using {command down, shift down}'
}
