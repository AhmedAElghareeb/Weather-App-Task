# ============================================================
# Flutter Clean Architecture Feature Generator
# ============================================================
# Usage:
#   .\create_feature.ps1 -FeatureName auth
#   .\create_feature.ps1 -FeatureName home
#   .\create_feature.ps1 -FeatureName product_details
# ============================================================

param (
    [Parameter(Mandatory = $true)]
    [string]$FeatureName
)

# ── Name helpers ─────────────────────────────────────────────

$snakeName = $FeatureName.ToLower().Replace("-", "_").Replace(" ", "_")
$pascalName = -join ($snakeName.Split('_') | ForEach-Object {
    $_.Substring(0, 1).ToUpper() + $_.Substring(1)
})
$camelName = ($snakeName.Split('_') | ForEach-Object -Begin { $first = $true } -Process {
    if ($first)
    {
        $first = $false; $_
    }
    else
    {
        $_.Substring(0, 1).ToUpper() + $_.Substring(1)
    }
}) -join ''

# ── Resolve base dir ─────────────────────────────────────────

$baseDir = "lib/src/features/$snakeName"

if (Test-Path $baseDir)
{
    Write-Host "[!]  Feature '$snakeName' already exists at $baseDir" -ForegroundColor Yellow
    $confirm = Read-Host "   Overwrite? [y/N]"
    if ($confirm -notmatch "^[Yy]$")
    {
        Write-Host "Aborted." -ForegroundColor Red
        exit 0
    }
}

Write-Host ""
Write-Host "[>>] Creating feature: $pascalName" -ForegroundColor Cyan
Write-Host "   Path: $baseDir"
Write-Host ""

# ── Create folders ───────────────────────────────────────────

$dirs = @(
    "$baseDir/cubit",
    "$baseDir/data/service",
    "$baseDir/data/models",
    "$baseDir/presentation/screens",
    "$baseDir/presentation/widgets"
)

foreach ($dir in $dirs)
{
    New-Item -ItemType Directory -Path $dir -Force | Out-Null
}

# ── Files ────────────────────────────────────────────────────

# 1. cubit/${snakeName}_state.dart
$stateContent = @"
part of '${snakeName}_cubit.dart';

enum ${pascalName}Status { initial, loading, loaded, error }

class ${pascalName}State extends Equatable {
  final ${pascalName}Status getDataStatus;
  final String message;

  const ${pascalName}State({
    this.getDataStatus = ${pascalName}Status.initial,
    this.message = '',
  });

  ${pascalName}State copyWith({
    ${pascalName}Status? getDataStatus,
    String? message,
  }) {
    return ${pascalName}State(
      getDataStatus: getDataStatus ?? this.getDataStatus,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [getDataStatus, message];
}
"@

# 2. cubit/${snakeName}_cubit.dart
$cubitContent = @"
import '../../../core/utils/di.dart';
import '../data/service/${snakeName}_service.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part '${snakeName}_state.dart';

class ${pascalName}Cubit extends Cubit<${pascalName}State> {
  ${pascalName}Cubit() : super(const ${pascalName}State());

  static ${pascalName}Cubit get(context) => BlocProvider.of(context);

  final ${pascalName}Service _${camelName}Service = di<${pascalName}ServiceImpl>();

  void initData() async {}

  void onRefresh() async {}
}
"@

# 3. data/service/${snakeName}_service.dart
$serviceContent = @"
import '../../../../core/network/api_helper.dart';

abstract class ${pascalName}Service {}

class ${pascalName}ServiceImpl with ApiHelper implements ${pascalName}Service {}
"@

# 4. data/models/${snakeName}_model.dart
$modelContent = @"
import 'package:equatable/equatable.dart';

class ${pascalName}Model extends Equatable {
  final int? id;

  const ${pascalName}Model({
     this.id,
  });

  ${pascalName}Model copyWith({
    int? id,
  }) => ${pascalName}Model(
    id: id ?? this.id,
  );

  factory ${pascalName}Model.fromJson(Map<String, dynamic> json) => ${pascalName}Model(
       id: json['id'],
     );

  Map<String, dynamic> toJson() => {
       'id': id,
     };

  @override
  List<Object?> get props => [id];
}
"@

# 5. presentation/screens/${snakeName}_screen.dart
$screenContent = @"
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/${snakeName}_cubit.dart';
import '../widgets/${snakeName}_body.dart';

class ${pascalName}Screen extends StatelessWidget {
  const ${pascalName}Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ${pascalName}Cubit()..initData(),
      child: const ${pascalName}Body(),
    );
  }
}
"@

# 6. presentation/widgets/${snakeName}_body.dart
$bodyContent = @"
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/components/app_appbars/global_appbar.dart';
import '../../cubit/${snakeName}_cubit.dart';

class ${pascalName}Body extends StatelessWidget {
  const ${pascalName}Body({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GlobalAppbar(title: '${pascalName}'.tr()),
      body: BlocBuilder<${pascalName}Cubit, ${pascalName}State>(
        builder: (context, state) {
          return switch (state.getDataStatus) {
            ${pascalName}Status.initial || ${pascalName}Status.loading => const Center(child: CircularProgressIndicator()),
            ${pascalName}Status.loaded  => const SizedBox.shrink(), // TODO: build your UI here
            ${pascalName}Status.error   => Center(child: Text(state.message)),
          };
        },
      ),
    );
  }
}
"@

# ── Write files ───────────────────────────────────────────────

$files = @{
    "$baseDir/cubit/${snakeName}_state.dart" = $stateContent
    "$baseDir/cubit/${snakeName}_cubit.dart" = $cubitContent
    "$baseDir/data/service/${snakeName}_service.dart" = $serviceContent
    "$baseDir/data/models/${snakeName}_model.dart" = $modelContent
    "$baseDir/presentation/screens/${snakeName}_screen.dart" = $screenContent
    "$baseDir/presentation/widgets/${snakeName}_body.dart" = $bodyContent
}

foreach ($file in $files.Keys)
{
    $files[$file] | Out-File -FilePath $file -Encoding utf8
    Write-Host "  [OK] $file" -ForegroundColor Green
}

# ── Summary ───────────────────────────────────────────────────

Write-Host ""
Write-Host "[DONE] Feature '$pascalName' created successfully!" -ForegroundColor Green
Write-Host ""
Write-Host "[Structure] Structure:" -ForegroundColor Cyan
Get-ChildItem -Path $baseDir -Recurse | ForEach-Object {
    $indent = "  " * ($_.FullName.Split("\").Count - $baseDir.Split("\").Count)
    Write-Host "$indent$( $_.Name )"
}
Write-Host ""
Write-Host "[Next steps] Next steps:" -ForegroundColor Cyan
Write-Host "  1. Register ${pascalName}ServiceImpl in your DI (injection_container.dart)"
Write-Host "  2. Add route path in ${snakeName}_screen.dart"
Write-Host "  3. Add the translation key for $snakeName to your .json files"
Write-Host "  4. Your Feature Ready To Implementations ... !!"
Write-Host ""