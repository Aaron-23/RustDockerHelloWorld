# The rocker framework requires a nightly build of rust to compile the application
FROM rustlang/rust:nightly as builder
WORKDIR /app
COPY . .
RUN cargo install --path .
# We don't need a special docker image to run the compiled application
FROM debian:buster-slim
WORKDIR /app
RUN apt-get update && apt-get install -y extra-runtime-dependencies
COPY --from=builder /usr/local/cargo/bin/RustDockerHelloWorld /app
CMD ["RustDockerHelloWorld"]