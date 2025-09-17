export enum Environment {
  Development = 'development',
  Production = 'production',
  Test = 'test',
}

export interface AppConfig {
  apikey: string;
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
  let env: Environment;

  switch (process.env.NODE_ENV) {
    case Environment.Production:
      env = Environment.Production;
      break;
    case Environment.Test:
      env = Environment.Test;
      break;
    case Environment.Development:
    default:
      env = Environment.Development;
      break;
  }

  return {
    apikey: process.env.API_KEY ?? '',
    env,
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

export function isDev(env: Environment): boolean {
  return env === Environment.Development;
}
