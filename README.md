# 🖥️ RENV Template

This template repository provides a way of containerising your R workflows by combining `Docker` and `renv`. This requires an opinionated stack of tools, and as such, I have decided to use the following:

- `OCI container runtime`; the `Dockerfile` and `.devcontainer.json` can be used with any OCI compatible runtime (`podman`) as well as `docker`
- Multi-stage builds to ensure that the resulting image contains all the packages required to run the analysis through the use of the `renv.lock` file format.
- VSCode: for its ability to have plugins and integration with GitHub and cruciallly, with its ability to use `Dev Containers` and work within a container
- `REditorSupport` provides `R` syntax highlighting, viewing plots and tables, as well as `LSP` support for `R` (syntax highlighting, linting, autocompletion).

# Workflow
To use this image, follow these steps:

- Click on the green `Use this template` button and create your repository under your own GitHub. During this creation process, you can mark this as Private and thus only you can see your document
- Pull your GitHub repository locally.
- Open VSCode, make sure you have the `Dev Containers` from Microsoft extensions installed.
- Open the folder where you have cloned the repository. VSCode will prompt you to open this folder with the `Dev Containers` extension.
- Et Viola! You now have a working locally built, CI/CD integrated, 

You can now:
- Modify `src/...` to add your `R` scripts and perform your analysis.
- Ensure you run `renv::snapshot()` for `renv` to find all of the packages you have used

## Optionally:
- Rebuild your container to digest the new packages inside the container so that when it restarts all the packages will be present inside the image
- Commit your changes to GitHub once you've done some code. GitHub will then initiate the build of the container image using GitHub Actions
    - Once this completes, you'll have a package release waiting, which you can optionnally make public

## Docker Image
The docker image, as seen in `.devcontainer/Dockerfile` uses `rocker/r-ver` with the `R` version set to `4.3.1`.

## Contributing
If you would like to contribute, please fork/fix/pull requests as you see fit. I've provisionally placed the repository under an MIT license.