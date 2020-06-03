# The rocker framework requires a nightly build of rust to compile the application
FROM rustlang/rust:nightly as builder
WORKDIR /app
COPY ./src/* ./src/
COPY *.toml ./
RUN cargo install --path .
# We don't need a special docker image to run the compiled application
FROM debian:buster-slim
WORKDIR /app
COPY --from=builder /usr/local/cargo/bin/RustDockerHelloWorld /app
CMD ["RustDockerHelloWorld"]