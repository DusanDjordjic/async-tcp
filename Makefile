CC=gcc
CFLAGS=-Wall -Wextra -Iinclude
LFLAGS=-pthread -L./lib -lchat

LIB_SRCS=lib/message.c
LIB_OBJS=lib/message.o
LIB=lib/libchat.a

SERVER_SRCS=server/main.c
SERVER_OBJS=$(SERVER_SRCS:.c=.o)
SERVER_BIN=server/server.out

CLIENT_SRCS=client/main.c
CLIENT_OBJS=$(CLIENT_SRCS:.c=.o)
CLIENT_BIN=client/client.out

.PHONY: all
all: lib $(SERVER_BIN) $(CLIENT_BIN)

.PHONY: lib
$(LIB): $(LIB_OBJS)
	ar rcs $@ $^

$(SERVER_BIN): $(SERVER_OBJS) $(LIB)
	$(CC) -o $@ $(SERVER_OBJS) $(LFLAGS)

$(CLIENT_BIN): $(CLIENT_OBJS) $(LIB)
	$(CC) -o $@ $(CLIENT_OBJS) $(LFLAGS)

%.o: %.c
	$(CC) -o $@ -c $< $(CFLAGS)

.PHONY: clean
clean:
	rm -rf $(LIB) $(LIB_OBJS) $(SERVER_BIN) $(SERVER_OBJS) $(CLIENT_BIN) $(CLIENT_OBJS)
