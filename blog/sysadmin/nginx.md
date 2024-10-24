# ==> [/](Blog) ==> SysAdmin ==> nginx configuration

## security

```
    ssl_protocols TLSv1.2 TLSv1.3;
	ssl_ciphers ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-CHACHA20-POLY1305:ECDHE-RSA-CHACHA20-POLY1305:DHE-RSA-AES128-GCM-SHA256:DHE-RSA-AES256-GCM-SHA384:DHE-RSA-CHACHA20-POLY1305;
	ssl_prefer_server_ciphers on;
	ssl_session_tickets off;
	ssl_session_timeout 1d;
	ssl_session_cache shared:SSL:10m;
	ssl_buffer_size 8k;
	ssl_stapling on;
	ssl_stapling_verify on;
```
and
```
	add_header X-Content-Type-Options nosniff;

	# should be
	# add_header Content-Security-Policy "object-src 'none'; base-uri 'none'; require-trusted-types-for 'script'; frame-ancestors 'self';";
	# but breaks grafana
	add_header Content-Security-Policy "object-src 'none'; frame-ancestors 'self';";
	add_header Content-Security-Policy "frame-ancestors 'self';";
	add_header Strict-Transport-Security "max-age=31536000; includeSubdomains; preload";
```

## JS modules need a change in default mime-type

```
types {
    text/javascript                           js mjs;
}
```

