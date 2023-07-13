# proxy
function proxy 
  export http_proxy="http://172.16.12.1:7890"
  export https_proxy=$http_proxy
  export socks5_proxy="socks5h://172.16.12.1:7890"
  echo "HTTP Proxy on"
end

# noproxy
function noproxy
  unset http_proxy
  unset https_proxy
  echo "HTTP Proxy off"
end

