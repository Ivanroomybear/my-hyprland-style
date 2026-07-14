#!/bin/bash

GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${BLUE}==============================${NC}"
echo -e "${GREEN}  🍵 Hyprland Style Installer  ${NC}"
echo -e "${BLUE}==============================${NC}"

# Warning
echo -e "${YELLOW}WARNING: This will overwrite your current waybar and wofi styles.${NC}"
echo -e "${YELLOW}Do you want to continue? (y/n)${NC}"
read -r answer

if [[ "$answer" != "y" && "$answer" != "Y" ]]; then
    echo -e "${RED}Installation cancelled.${NC}"
    exit 0
fi

echo -e "${GREEN}Installing styles...${NC}"

# Waybar
mkdir -p ~/.config/waybar
cat > ~/.config/waybar/style.css << 'EOF'
* {
    font-family: "Font Awesome 6 Free", "Font Awesome 5 Free", sans-serif;
    font-size: 13px;
    font-weight: bold;
    border: none;
    box-shadow: none;
    text-shadow: none;
}

window#waybar {
    background-color: transparent;
}

/* БАЗОВЫЙ СТИЛЬ ОСТРОВКОВ */
#workspaces,
#clock,
#pulseaudio,
#battery,
#network {
    background-color: rgba(20, 20, 30, 0.85);
    padding: 2px 14px;
    margin: 0;
    border-radius: 10px;
    border: 1px solid transparent; 
    transition: all 0.15s ease-in-out;
}

/* У воркспейсов убираем внутренние отступы самого контейнера, переносим их на кнопки */
#workspaces {
    padding: 0;
}

#pulseaudio, #battery {
    margin-right: 6px;
}

/* Сбрасываем дефолтный фон кнопок */
#workspaces button,
#waybar button:hover {
    background: transparent;
    background-color: transparent;
}

/* НАСТРОЙКА КНОПОК ЦИФР */
#workspaces button {
    font-family: sans-serif;
    padding: 4px 14px;
    color: rgba(255, 255, 255, 0.4);
    border-radius: 10px;
    border: 1px solid transparent;
    transition: all 0.15s ease-in-out;
}

#workspaces button.active {
    color: #89b4fa;
}

/* ХОВЕРЫ С ВНУТРЕННИМ НЕОНОВЫМ СВЕЧЕНИЕМ ДЛЯ ВСЕХ ЭЛЕМЕНТОВ И КНОПОК ПАНЕЛИ */
#workspaces button:hover,
#clock:hover,
#pulseaudio:hover,
#battery:hover,
#network:hover {
    background-color: rgba(45, 45, 70, 0.9);
    border: 1px solid #89b4fa;
    box-shadow: inset 0 0 8px rgba(137, 180, 250, 0.6);
    border-radius: 10px;
}

/* ФИКС КАЛЕНДАРЯ (TOOLTIP) — ТЕПЕРЬ СВЕТИТСЯ СТРОГО ВНУТРЬ КРУГА */
tooltip {
    background-color: rgba(20, 20, 30, 0.95);
    border-radius: 12px;
    border: 1px solid #89b4fa;
    /* Убираем внешнее облако и пускаем неоновый свет ИНСЕТОМ внутрь самого окна */
    box-shadow: inset 0 0 10px rgba(137, 180, 250, 0.6);
    padding: 15px;
}

tooltip label {
    font-family: "JetBrainsMono Nerd Font", monospace;
    font-size: 13px;
    color: #cdd6f4;
    background-color: transparent;
}

/* СКРУГЛЕНИЕ ДЛЯ ЯЧЕЕК КАЛЕНДАРЯ И ИХ ПОДСВЕТКИ */
calendar {
    border-radius: 10px;
}

calendar button,
calendar button:hover,
calendar tile:hover {
    border-radius: 6px;
    border: 1px solid transparent;
    transition: all 0.1s ease-in-out;
}

/* ВНУТРЕННИЙ НЕОНОВЫЙ СВЕТ ПРИ НАВЕДЕНИИ НА СТРЕЛОЧКИ МЕСЯЦЕВ СВЕРХУ */
calendar header button:hover {
    background-color: rgba(45, 45, 70, 0.9);
    border: 1px solid #89b4fa;
    box-shadow: inset 0 0 6px rgba(137, 180, 250, 0.6);
    border-radius: 6px;
}

/* ВНУТРЕННИЙ НЕОНОВЫЙ СВЕТ ПРИ НАВЕДЕНИИ НА ЧИСЛА МЕСЯЦА СНИЗУ */
calendar view button:hover {
    background-color: rgba(45, 45, 70, 0.9);
    border: 1px solid #89b4fa;
    box-shadow: inset 0 0 6px rgba(137, 180, 250, 0.6);
    border-radius: 6px;
}

#clock { color: #bac2de; }
#pulseaudio { color: #a6e3a1; }
#battery { color: #f9e2af; }
#network { color: #89b4fa; }
EOF

cat > ~/.config/waybar/config << 'EOF'
{
    "layer": "top",
    "position": "top",
    "height": 34,
    "margin-top": 6,
    "margin-left": 10,
    "margin-right": 10,
    "spacing": 0,

    "modules-left": ["hyprland/workspaces"],
    "modules-center": ["clock"],
    "modules-right": ["pulseaudio", "battery", "network"],

    "hyprland/workspaces": {
        "format": "{name}",
        "on-click": "activate"
    },
    "clock": {
        "format": "   {:%d.%m   |      %H:%M}",
        "tooltip-format": "<big>{:%B %Y}</big>\n\n{calendar}"
    },
    "pulseaudio": {
        "format": "   {volume}%",
        "format-muted": "   Выкл",
        "on-click": "pavucontrol"
    },
    "battery": {
        "states": {
            "warning": 30,
            "critical": 15
        },
        "format": "   {capacity}%",
        "format-charging": "   {capacity}%",
        "format-plugged": "   {capacity}%"
    },
    "network": {
        /* ЖЕСТКИЙ ФИКС ВИЗУАЛЬНОГО ЗНАЧКА СЕТИ (РАБОЧИЕ ИКОНКИ FONT AWESOME) */
        "format-wifi": "   {essid}",
        "format-ethernet": "   Кабель",
        "format-disconnected": "   Откл"
    }
}
EOF

# Wofi
mkdir -p ~/.config/wofi
cat > ~/.config/wofi/style.css << 'EOF'
/* БАЗОВЫЕ НАСТРОЙКИ ШРИФТОВ И СБРОС СТИЛЕЙ */
* {
    font-family: "Font Awesome 6 Free", "Font Awesome 5 Free", sans-serif;
    font-size: 13px;
    font-weight: bold;
    border: none;
    box-shadow: none;
    text-shadow: none;
}

/* ГЛАВНОЕ ОКНО WOFI */
window {
    background-color: rgba(20, 20, 30, 0.95);
    border-radius: 12px;
    border: 1px solid #89b4fa;
    box-shadow: inset 0 0 10px rgba(137, 180, 250, 0.6);
    padding: 15px;
}

/* КОНТЕЙНЕР ДЛЯ ПОЛЯ ВВОДА И СПИСКА */
#outer-box {
    padding: 5px;
}

/* ПОЛЕ ВВОДА (ПОИСК) */
#input {
    background-color: rgba(20, 20, 30, 0.85);
    color: #ffffff;
    padding: 8px 14px;
    margin-bottom: 10px;
    border-radius: 10px;
}

/* ФОКУС НА ПОЛЕ ВВОДА */
#input:focus {
    background-color: rgba(45, 45, 70, 0.9);
    border: 1px solid #89b4fa;
    box-shadow: inset 0 0 8px rgba(137, 180, 250, 0.6);
}

/* СПИСОК РЕЗУЛЬТАТОВ */
#scroll {
    margin-top: 5px;
}

#text {
    color: #cdd6f4;
}

/* ОТДЕЛЬНЫЕ ЭЛЕМЕНТЫ СПИСКА (ПРИЛОЖЕНИЯ) */
#entry {
    padding: 6px 14px;
    margin: 2px 0px;
    border-radius: 10px;
}

/* ВЫБОР СВЕТИТСЯ ОДИН В ОДИН КАК ПОИСК ПРИ ФОКУСЕ */
#entry:hover,
#entry:selected {
    background-color: rgba(45, 45, 70, 0.9);
    border: 1px solid #89b4fa;
    box-shadow: inset 0 0 8px rgba(137, 180, 250, 0.6);
}

#entry:hover #text,
#entry:selected #text {
    color: #ffffff;
}

/* ИКОНКИ ПРИЛОЖЕНИЙ */
#img {
    margin-right: 10px;
}

/* ===================================================================
   МАССОВЫЙ ВЫЖИГААТЕЛЬ СЕРЫХ ЗУБЧИКОВ ИЗ ВСЕХ КИШЕК GTK3
   =================================================================== */

/* Сбрасываем фоны у выделенного текста и картинок (это убрало синеву) */
#text:selected,
#img:selected {
    background-color: transparent;
    background: transparent;
}

/* Полностью уничтожаем любые рамки, иконки, стрелочки и фокусы 
   у элементов expander и arrow, которые Wofi понимает без синтаксических ошибок */
expander,
arrow,
button {
    background-color: transparent;
    background: transparent;
    border: none;
    padding: 0;
    margin: 0;
    width: 0px;
    height: 0px;
    -gtk-icon-source: none;
}
EOF

cat > ~/.config/wofi/config << 'EOF'
prompt=Search...
show=drun
show_all=false
print_command=true
dynamic_lines=true
EOF

echo -e "${BLUE}==============================${NC}"
echo -e "${GREEN}✅ Style installed successfully.${NC}"
echo -e "${BLUE}==============================${NC}"
