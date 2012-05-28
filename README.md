# zeshin 

<https://github.com/dbb/zeshin>

## Description

**Zeshin** is a tool to help you manage your important configuration on different machines using git. It is named after [the Japanese painter](https://en.wikipedia.org/wiki/Zeshin). I designed it for use with `zsh`, but it can easily be used to handle any arbitrary list of files.

## Downloading
The easiest way to get the script is one of the following:

    curl -LO tiny.cc/zeshin
    wget tiny.cc/zeshin

If you have neither curl nor wget, you can simply use a browser.

## Prerequisites

You must have an active Github account and a valid `~/.gitconfig`. The script uses `zsh` as its interpreter, so you must have it installed but it doesn't have to be your shell


## Usage

First, download the script and add it to your `$PATH`. Then check the `files` variable at the beginning of the script to make sure everything you want to track is there, and run `zeshin init` to create a Github repo called `myzeshin`.

On another machine, just run `zeshin dl` and your configs are ready.

If you've edited your files and want to upload them to Github, run `zeshin ul`.

