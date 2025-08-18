mix escript.install hex protobuf
mix escript.install hex protoc_gen_grpc

protoc \
  --elixir_out=plugins=grpc:./lib/web/grpc/generated \
  ./lib/web/grpc/weather.proto