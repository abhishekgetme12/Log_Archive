# Log_Archive
📜 Remote Log Archiver Utility

A powerful batch script solution to remotely archive and clean up log files from multiple services without service interruption. Keep your servers running smoothly while maintaining optimal disk space! 🚀

🌟 Key Features
Zero Downtime - Moves logs without restarting services

Multi-Server Support - Handles logs from multiple services simultaneously

Time-Based Archiving - Configurable retention period (in days)

Disk Space Savior - Automatically clears space on source servers

Flexible Destination - Specify any accessible archive location

Simple Configuration - Easy-to-edit variables for your environment

🛠 How It Works
Diagram
graph TD
    A[Source Server] -->|1. Identify Logs| B[Filter by Date]
    B -->|2. Select Older Than X Days| C[Move/Copy to Archive]
    C -->|3. Verify Transfer| D[Destination Server]
    D -->|4. Clean Source| E[Free Up Disk Space]




📥 Installation
Clone or download the script to your admin workstation

Edit the configuration section with your environment details

Run with appropriate permissions

batch
git clone https://github.com/abhishekgetme12/Log_Archive.git

⚙️ Configuration
Customize these variables in the script:

batch
SET "servers=server1,server2,server3"
SET "services=service1,service2"
SET "source_path=\\server\logs\service"
SET "dest_path=\\archive\logs\service"
SET "days_to_keep=30"
SET "cleanup_mode=MOVE"  :: MOVE or DELETE
🚀 Usage
batch
archive_logs.bat [days] [source] [destination] [mode]

Example:
archive_logs.bat 30 "\\prod-srv\logs\app\" "\\nas\archive\logs\" MOVE
📊 Benefits
✔ Prevent Disk Overflow - Regular log rotation
✔ Compliance Ready - Maintain log archives for audits
✔ Performance Boost - Reduce I/O pressure on production servers
✔ Centralized Logs - All archives in one searchable location
✔ Non-Disruptive - Services keep running during operation

🤝 Contributing
Pull requests welcome! For major changes, please open an issue first to discuss.

📜 License
MIT

💡 Pro Tip: Schedule this script to run weekly in Task Scheduler for automated log management!