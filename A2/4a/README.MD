# WordPress VM und MySQL VM
In `site-cookbooks` befindet sich das eigene Kochbuch für den MySQL-Server. Die
mittels `librarian-chef` installierten Kochbücher sind nicht im Repository 
enthalten, können jedoch mithile des `Cheffile` installiert werden. In `nodes`
befinden sich die Konfigurationsdateien für die beiden Server. In `helpers`
befinden sich die Helfer-Dateien, die für das Einrichten der Datenbankberechtigungen
benötigt werden. `knife.rb` ist die Konfigurationsdatei für knife, `run.sh` das
Skript um die beiden VMs zu erzeugen und zu konfigurieren.
