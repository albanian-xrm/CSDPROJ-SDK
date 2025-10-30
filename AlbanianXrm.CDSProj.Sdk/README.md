# AlbanianXrm.CDSProj.Sdk

A visual studio sdk project based on the Microsoft provided .cdsproj project with support for Plugin Package dependencies. This project can be part of a Visual Studio solution and can be opened on visual studio

To use this just reference the Sdk using a specific version and the build system should get the definition from NuGet.

```xml
<?xml version="1.0" encoding="utf-8"?>
<Project Sdk="AlbanianXrm.CDSProj.Sdk/1.0.7">
</Project>
```

Reference your plugin packages and PCFs normally using ProjectReference tags.

```xml
<?xml version="1.0" encoding="utf-8"?>
<Project Sdk="AlbanianXrm.CDSProj.Sdk/1.0.7">
	<ItemGroup>
		<ProjectReference Include="..\AlbanianXrm.OtherPluginPackage\AlbanianXrm.OtherPluginPackage.csproj" />
		<ProjectReference Include="..\AlbanianXrm.PluginPackage\AlbanianXrm.PluginPackage.csproj" />
		<ProjectReference Include="..\AlbanianXrm.YetAnotherPluginPackage\AlbanianXrm.YetAnotherPluginPackage.csproj">
			<ManagedIdentityId>50d2aee4-08c4-4f5d-bb9b-9ce93923da42</ManagedIdentityId>
		</ProjectReference>
		<ProjectReference Include="..\AlbanianXrm.LinearInputPCF\AlbanianXrm.LinearInputPCF.pcfproj" />
	</ItemGroup>
</Project>
```

The version of the packaged solution and plugins will be read in the `solution.xml` file if the `FileVersion` property is not specified during build.

If you want to use [Managed Identities](https://learn.microsoft.com/en-us/power-platform/admin/set-up-managed-identity) then specify the `ManagedIdentityId` property in your plugin package project or in the `ProjectReference`. 
There is a target that makes sure that the `pluginpackage.xml` is properly regenerated on build.