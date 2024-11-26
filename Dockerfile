FROM alpine:latest as build

WORKDIR "/opt"
RUN apk add curl gcc git musl-dev
RUN curl --proto '=https' -tlsv1.2 -sSf https://sh.rustup.rs -o ./install_rustup
RUN chmod +x ./install_rustup
RUN ./install_rustup --default-toolchain nightly -y
RUN git clone https://git.casuallyblue.dev/vega/nova-rust.git

WORKDIR "nova-rust"
RUN $HOME/.cargo/bin/cargo build --release

FROM alpine:latest as run

COPY --from=build /opt/nova-rust/target/release/frontend /bin/
COPY eval /bin/
COPY eval-discord /bin/

WORKDIR "tmp"
CMD ["eval"]
