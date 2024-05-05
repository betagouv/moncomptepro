import { promises as fs } from "fs";
import { Pool } from "pg";
import { getDatabaseConnection } from "../src/connectors/postgres";

const runScript = async (filePath: string): Promise<void> => {
  let connection: Pool | null = null;
  try {
    const scriptContent = await fs.readFile(filePath, { encoding: "utf-8" });
    connection = getDatabaseConnection();
    await connection.query(scriptContent);
    console.log(`Successfully ran script: ${filePath}`);
  } catch (error) {
    console.error(`Error running script: ${filePath}`, error);
  } finally {
    if (connection) {
      await connection.end();
    }
  }
};

const args = process.argv.slice(2);
if (args.length !== 1) {
  console.error("Usage: ts-node run-sql-scripts.ts <path to SQL file>");
  process.exit(1);
}

const filePath = args[0];
runScript(filePath);
