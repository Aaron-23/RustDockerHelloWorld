# The rocket framework requires a nightly build of rust to compile the application
FROM rustlang/rust:nightly as builder
WORKDIR /app
COPY ./src/* /app/src/
COPY ./*.toml /app/
RUN cargo install --path /app
# We don't need a special docker image to run the compiled application
FROM debian:buster-slim
WORKDIR /app
COPY --from=builder /usr/local/cargo/bin/RustDockerHelloWorld ./
# We need the rocket config file in the application directory
COPY Rocket.toml ./
ENTRYPOINT ["./RustDockerHelloWorld"]