# AlbanianXrm.CDSProj.Sdk

A visual studio sdk project based on the Microsoft provided .cdsproj project with support for Plugin Package dependencies. This project can be part of a Visual Studio solution and can be opened on visual studio

To use this just reference the Sdk using a specific version and the build system should get the definition from NuGet.

```xml
<?xml version="1.0" encoding="utf-8"?>
<Project Sdk="AlbanianXrm.CDSProj.Sdk/1.0.1">
	<ItemGroup>
		<ProjectReference Include="..\AlbanianXrm.OtherPluginPackage\AlbanianXrm.OtherPluginPackage.csproj" />
		<ProjectReference Include="..\AlbanianXrm.PluginPackage\AlbanianXrm.PluginPackage.csproj" />
		<ProjectReference Include="..\AlbanianXrm.LinearInputPCF\AlbanianXrm.LinearInputPCF.pcfproj" />
	</ItemGroup>

</Project>
```