export enum Environment {
  Development = 'development',
  Production = 'production',
  Test = 'test',
}

export interface AppConfig {
  env: Environment;
  port: number;
  db: {
    host: string;
    port: number;
    user: string;
    password: string;
    name: string;
  };
}

export function loadConfig(): AppConfig {
  return {
    env: (process.env.NODE_ENV as Environment) ?? Environment.Development,
    port: parseInt(process.env.PORT ?? '3000', 10),
    db: {
      host: process.env.POSTGRES_HOST ?? 'localhost',
      port: parseInt(process.env.POSTGRES_PORT ?? '5432', 10),
      user: process.env.POSTGRES_USER ?? 'movies',
      password: process.env.POSTGRES_PASSWORD ?? 'password',
      name: process.env.POSTGRES_NAME ?? 'moviesdb',
    },
  };
}
