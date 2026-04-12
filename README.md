## Drive Letter Configuration

### Scoop Installation on Custom Drives

You can configure Scoop to manage installations on custom drive letters by following these steps:

1. **Install Scoop**:
   You can install Scoop on any drive by running the installation command from the desired drive letter. For example:
   ```powershell
   # Open PowerShell
   cd D:\
   iwr get.scoop.sh -useb | iex
   ```

2. **Set Up Custom Directory**:
   To set up Scoop on a custom drive, use the `SCOOP` environment variable to point to your desired installation path. You can do this by adding the following line to your PowerShell profile:
   ```powershell
   $env:SCOOP='D:\scoop'
   ```

3. **Verify Installation**:
   Verify that Scoop is installed by running:
   ```powershell
   scoop help
   ```

This will confirm that any installations or applications you manage through Scoop can be accessed and executed properly from the custom drive setup.

Feel free to reach out for any additional information or troubleshooting steps on the setup process!