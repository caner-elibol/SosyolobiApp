using Microsoft.EntityFrameworkCore.Migrations;
using Microsoft.EntityFrameworkCore.Migrations.Internal;
using Npgsql.EntityFrameworkCore.PostgreSQL.Migrations.Internal;

#pragma warning disable EF1001

namespace Sosyolobi.Api.Data;

public class NamingConventionsHistoryRepository : NpgsqlHistoryRepository
{
    public NamingConventionsHistoryRepository(HistoryRepositoryDependencies dependencies)
        : base(dependencies) { }

    protected override string MigrationIdColumnName => "migration_id";
    protected override string ProductVersionColumnName => "product_version";

    public override string GetCreateScript() =>
        $"""
        CREATE TABLE {SqlGenerationHelper.DelimitIdentifier(TableName, TableSchema)} (
            migration_id character varying(150) NOT NULL,
            product_version character varying(32) NOT NULL,
            CONSTRAINT "PK___EFMigrationsHistory" PRIMARY KEY (migration_id)
        );
        """;

    public override string GetCreateIfNotExistsScript() =>
        $"""
        CREATE TABLE IF NOT EXISTS {SqlGenerationHelper.DelimitIdentifier(TableName, TableSchema)} (
            migration_id character varying(150) NOT NULL,
            product_version character varying(32) NOT NULL,
            CONSTRAINT "PK___EFMigrationsHistory" PRIMARY KEY (migration_id)
        );
        """;
}
