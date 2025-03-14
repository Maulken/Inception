# Utilise Alpine comme image de base
FROM alpine:3.19

# Met à jour et installer les paquets nécessaires
#    - nginx : le serveur web
#   - openssl : pour générer les certificats SSL
#   - curl : pour des tests de connectivité HTTP, utile en développement
# Possible de decaler les lignes suivantes ?
RUN apk update && \
	apk upgrade && \
	apk add --no-cache \
		nginx \
		openssl \
		curl

# Crée le répertoire pour le site web et définir les permissions
RUN mkdir -p /var/www/html
RUN chown -R nginx:nginx /var/www/html
RUN chmod -R 755 /var/www/html

#  Copie la configuration personnalisée pour Nginx
COPY conf/nginx.conf /etc/nginx/

# Génére un certificat SSL auto-signé
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
	-keyout /etc/ssl/private/cert.key \
	-out /etc/ssl/certs/cert.crt \
	-subj "/C=FR/ST=LeHavre/L=LeHavre/O=42/OU=42/CN=vmassoli.42.fr"

# Redirige les logs Nginx vers la sortie standard (stdout/stderr)
RUN ln -sf /dev/stdout /var/log/nginx/access.log && \
	ln -sf /dev/stderr /var/log/nginx/error.log

EXPOSE 443

# Démarrage
CMD ["nginx", "-g", "daemon off;"]
