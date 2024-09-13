#!/usr/bin/env zsh
# // ▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲  DEFINE LOG COLORS ▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲
NO_COLOR="\e[0m"
RED="\033[31m"
GREEN="\033[32m"
YELLOW="\033[33m"

# // ▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲  FIND SHELL AND ITS VARIABLES▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲
SHELL_RC="${HOME}/.zshrc"
# // ▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲  PREPARING DNS CHANGER ▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲
# // ▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲  CHECK ALIASES
function check_alias() {
  source "${SHELL_RC}"

  alias_name="$1"

  if alias "$alias_name" &>/dev/null; then
    echo "Alias '$alias_name' exists."
  else
    UNALIASED_LIST+=("$alias_name")
    echo "${YELLOW}Alias '$alias_name' does not exists.I will add it for you...${NO_COLOR}"
  fi
}

ALIASES_LIST=("up403" "upshecan" "upbogzar" "downdns" "dnsstatus")
UNALIASED_LIST=()

for alias in "${ALIASES_LIST[@]}"; do
  check_alias "$alias"
done

function add_alias() {
  alias_name="$1"

  case $alias_name in
  "up403")
    echo 'alias up403="nmcli connection modify $connectionName ipv4.dns \"10.202.10.202,10.202.10.102\" && nmcli connection modify $connectionName ipv4.ignore-auto-dns yes && nmcli connection show $connectionName | grep -e ipv4.dns -e ipv4.ignore && systemctl restart NetworkManager"' >>"${SHELL_RC}"
    ;;
  "upshecan")
    echo 'alias upshecan="nmcli connection modify  $connectionName ipv4.dns \"185.51.200.2,178.22.122.100\" && nmcli connection modify $connectionName ipv4.ignore-auto-dns yes && nmcli connection show $connectionName | grep -e ipv4.dns -e ipv4.ignore && systemctl restart NetworkManager"' >>"${SHELL_RC}"
    ;;
  "upbogzar")
    echo 'alias upbogzar="nmcli connection modify $connectionName ipv4.dns \"185.55.226.26,185.55.225.25\" && nmcli connection modify $connectionName ipv4.ignore-auto-dns yes && nmcli connection show $connectionName | grep -e ipv4.dns -e ipv4.ignore && systemctl restart NetworkManager"' >>"${SHELL_RC}"
    ;;
  "downdns")
    echo 'alias downdns="nmcli connection modify $connectionName ipv4.dns '' && nmcli connection modify $connectionName ipv4.ignore-auto-dns no && nmcli connection show $connectionName | grep -e ipv4.dns -e ipv4.ignore && systemctl restart NetworkManager"' >>"${SHELL_RC}"
    ;;
  "dnsstatus")
    echo 'alias dnsstatus="nmcli connection show $connectionName | grep -e ipv4.dns -e ipv4.ignore "' >> "${SHELL_RC}"
    ;;
  *)
    echo "${RED}There is problem\!\! I doesn't do my job${NO_COLOR}"
    ;;
  esac
}

if [[ "${#UNALIASED_LIST[@]}" -gt 0 ]]; then
  echo "# ▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲ DNS CHANGER ALIASES ▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲ " >>"${HOME}/.zshrc"
  echo "connectionName=\$(nmcli connection show --active | sed -n '2p' | awk '{print \$1}')" >>"${SHELL_RC}"

  for unaliased in "${UNALIASED_LIST[@]}"; do
    add_alias "$unaliased"
  done

  echo "# ▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲ DNS CHANGER ALIASES [end] ▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲ " >>"${SHELL_RC}"
  echo "${GREEN}Add successfuly aliases to ${SHELL_RC}${NO_COLOR}"
  source "${SHELL_RC}"
fi

# // ▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲  IMPLEMENTING DNS CHECKER ▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲
echo ""
echo "▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲"
echo ""
echo "Starting DNS check..."
CONNECTION_NAME=$(nmcli connection show --active | sed -n '2p' | awk '{print $1}')

DNS_LIST=(
  "10.202.10.202" "10.202.10.102" # 403
  "178.22.122.100" "185.51.200.2" # shecan
  "185.55.226.26" "185.55.225.25" # bogzar
)

while true; do
  CURRENT_DNS=$(nmcli connection show $CONNECTION_NAME | grep ipv4.dns | awk '{print $2}' | head -n 1)

  # // ▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲  DELIMITER EACH DNS ▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲
  FIRST_DNS=$(echo "${CURRENT_DNS}" | cut -d ',' -f1)
  SECOND_DNS=$(echo "${CURRENT_DNS}" | cut -d ',' -f2)

  # // ▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲  FIND PROVIDER OF DNS ▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲
  PROVIDER=
  dns=$FIRST_DNS
  case $dns in
  "${DNS_LIST[1]}" | "${DNS_LIST[2]}")
    PROVIDER="403.online"
    ;;

  "${DNS_LIST[3]}" | "${DNS_LIST[4]}")
    PROVIDER="Shecan"
    ;;

  "${DNS_LIST[5]}" | "${DNS_LIST[6]}")
    PROVIDER="Bogzar"
    ;;

  *)
    PROVIDER="Unknown"
    ;;
  esac

  # // ▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲  SHOW DNS NOTIFY TO USER ▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲
  if [[ " ${DNS_LIST[@]} " =~ " ${FIRST_DNS} " ]]; then
    notify-send -t 10000 -u critical "Connected to Custom DNS" \
      "You are now using the custom DNS servers\!\!\!\n\
Your DNS is ${CURRENT_DNS}
Your DNS Provider is ${PROVIDER} "
  fi
  sleep 60
done
