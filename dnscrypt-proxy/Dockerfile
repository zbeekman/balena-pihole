
FROM klutchell/dnscrypt-proxy:2.0.19-arm

# enable cisco-familyshield by appending a new server_names list to the end
# of the default config file
RUN echo "server_names = ['cisco-familyshield']" >> /config/dnscrypt-proxy.toml
