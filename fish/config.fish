set fish_greeting
if status is-interactive
        printf "\
\x1b[1;31m     ___    \x1b[33m     \x1b[32m     \x1b[35m__  
\x1b[1;31m    /   |  \x1b[33m_____\x1b[32m_____\x1b[35m/ /_ 
\x1b[1;31m   / /| | \x1b[33m/ ___\x1b[32m/ ___\x1b[35m/ __ \\
\x1b[1;31m  / ___ |\x1b[33m/ /  \x1b[32m/ /__\x1b[35m/ / / /
\x1b[1;31m /_/  |_\x1b[33m/_/  \x1b[32m \___\x1b[35m/_/ /_/
"
end
