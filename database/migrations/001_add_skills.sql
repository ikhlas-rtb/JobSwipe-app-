CREATE TABLE IF NOT EXISTS skills (
    id SERIAL PRIMARY KEY,
    name VARCHAR(150) UNIQUE NOT NULL
);

CREATE TABLE IF NOT EXISTS job_skills (
    id SERIAL PRIMARY KEY,
    job_id INT NOT NULL REFERENCES jobs(id) ON DELETE CASCADE,
    skill_id INT NOT NULL REFERENCES skills(id) ON DELETE CASCADE,
    importance INT DEFAULT 1
);

CREATE TABLE IF NOT EXISTS user_skills (
    id SERIAL PRIMARY KEY,
    user_id INT NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    skill_id INT NOT NULL REFERENCES skills(id) ON DELETE CASCADE,
    level VARCHAR(50),
    years INT
);

INSERT INTO skills (name) VALUES
('airflow'),
('alpine'),
('android'),
('angular'),
('ansible'),
('api design'),
('asp.net'),
('aws'),
('babel'),
('backbone'),
('bash'),
('bdd'),
('bitbucket'),
('c'),
('c#'),
('c++'),
('caching'),
('chef'),
('circleci'),
('cloudformation'),
('content delivery network'),
('css3'),
('cypress'),
('cqrs'),
('datadog'),
('dbt'),
('debian'),
('django'),
('dns'),
('docker'),
('dotnet'),
('dynamodb'),
('e2e testing'),
('elasticsearch'),
('elk'),
('elixir'),
('ember'),
('encryption'),
('event-driven architecture'),
('ecs'),
('eks'),
('eks-gke'),
('fastapi'),
('feature engineering'),
('flask'),
('fluentd'),
('flutter'),
('gcp'),
('gatsby'),
('git'),
('github'),
('github-actions'),
('gitlab'),
('gitlab-ci'),
('go'),
('gke'),
('graphql'),
('grpc'),
('hadoop'),
('haproxy'),
('helm'),
('hive'),
('html5'),
('http'),
('https'),
('iam'),
('influxdb'),
('intellij'),
('iot'),
('jenkins'),
('jest'),
('jmeter'),
('json'),
('junit'),
('kafka'),
('kibana'),
('kotlin'),
('kubernetes'),
('kvm'),
('laravel'),
('load balancing'),
('load testing'),
('locust'),
('logstash'),
('lua'),
('mariadb'),
('memcached'),
('mongodb'),
('mssql'),
('mysql'),
('new relic'),
('nginx'),
('nodejs'),
('nosql'),
('numpy'),
('oauth2'),
('openapi'),
('openstack'),
('openshift'),
('opentelemetry'),
('openid connect'),
('oracle'),
('packer'),
('parcel'),
('performance tuning'),
('php'),
('playwright'),
('postgresql'),
('presto'),
('powershell'),
('profiling'),
('prometheus'),
('protobuf'),
('puppet'),
('pandas'),
('python'),
('pytorch'),
('pytest'),
('rabbitmq'),
('react'),
('react-native'),
('redis'),
('redis cache'),
('rest'),
('ruby'),
('ruby on rails'),
('rust'),
('rhel'),
('saml'),
('scalability'),
('scala'),
('scikit-learn'),
('security'),
('selenium'),
('shell'),
('sass'),
('scss'),
('sentry'),
('serverless'),
('service mesh'),
('shell scripting'),
('spring'),
('spring-boot'),
('sql'),
('sql tuning'),
('sqlite'),
('ssl'),
('swift'),
('swiftui'),
('symfony'),
('svelte'),
('terraform'),
('testing'),
('tensorflow'),
('trino'),
('typescript'),
('tcp/ip'),
('tdd'),
('travisci'),
('ubuntu'),
('unreal engine'),
('unity'),
('vagrant'),
('vite'),
('vmware'),
('vscode'),
('vue'),
('windows server'),
('yaml'),
('zipkin')
ON CONFLICT (name) DO NOTHING;

-- seeding jobs
INSERT INTO job_skills (job_id, skill_id, importance)
SELECT 1, id, 3 FROM skills WHERE name = 'networks' ON CONFLICT DO NOTHING;
INSERT INTO job_skills (job_id, skill_id, importance)
SELECT 1, id, 2 FROM skills WHERE name = 'itil' ON CONFLICT DO NOTHING;
INSERT INTO job_skills (job_id, skill_id, importance)
SELECT 1, id, 2 FROM skills WHERE name = 'automation' ON CONFLICT DO NOTHING;

INSERT INTO job_skills (job_id, skill_id, importance)
SELECT 2, id, 3 FROM skills WHERE name = 'networks' ON CONFLICT DO NOTHING;
INSERT INTO job_skills (job_id, skill_id, importance)
SELECT 2, id, 3 FROM skills WHERE name = 'active directory' ON CONFLICT DO NOTHING;
INSERT INTO job_skills (job_id, skill_id, importance)
SELECT 2, id, 2 FROM skills WHERE name = 'sccm' ON CONFLICT DO NOTHING;
INSERT INTO job_skills (job_id, skill_id, importance)
SELECT 2, id, 2 FROM skills WHERE name = 'intune' ON CONFLICT DO NOTHING;
INSERT INTO job_skills (job_id, skill_id, importance)
SELECT 2, id, 2 FROM skills WHERE name = 'windows server' ON CONFLICT DO NOTHING;

INSERT INTO job_skills (job_id, skill_id, importance)
SELECT 3, id, 3 FROM skills WHERE name = 'vmware' ON CONFLICT DO NOTHING;
INSERT INTO job_skills (job_id, skill_id, importance)
SELECT 3, id, 3 FROM skills WHERE name = 'active directory' ON CONFLICT DO NOTHING;
INSERT INTO job_skills (job_id, skill_id, importance)
SELECT 3, id, 2 FROM skills WHERE name = 'linux' ON CONFLICT DO NOTHING;
INSERT INTO job_skills (job_id, skill_id, importance)
SELECT 3, id, 2 FROM skills WHERE name = 'azure' ON CONFLICT DO NOTHING;
INSERT INTO job_skills (job_id, skill_id, importance)
SELECT 3, id, 2 FROM skills WHERE name = 'aws' ON CONFLICT DO NOTHING;
INSERT INTO job_skills (job_id, skill_id, importance)
SELECT 3, id, 2 FROM skills WHERE name = 'sccm' ON CONFLICT DO NOTHING;
INSERT INTO job_skills (job_id, skill_id, importance)
SELECT 3, id, 1 FROM skills WHERE name = 'intune' ON CONFLICT DO NOTHING;

INSERT INTO job_skills (job_id, skill_id, importance)
SELECT 4, id, 3 FROM skills WHERE name = 'linux' ON CONFLICT DO NOTHING;
INSERT INTO job_skills (job_id, skill_id, importance)
SELECT 4, id, 3 FROM skills WHERE name = 'ansible' ON CONFLICT DO NOTHING;
INSERT INTO job_skills (job_id, skill_id, importance)
SELECT 4, id, 2 FROM skills WHERE name = 'terraform' ON CONFLICT DO NOTHING;
INSERT INTO job_skills (job_id, skill_id, importance)
SELECT 4, id, 2 FROM skills WHERE name = 'aws' ON CONFLICT DO NOTHING;
INSERT INTO job_skills (job_id, skill_id, importance)
SELECT 4, id, 2 FROM skills WHERE name = 'azure' ON CONFLICT DO NOTHING;
INSERT INTO job_skills (job_id, skill_id, importance)
SELECT 4, id, 1 FROM skills WHERE name = 'vmware' ON CONFLICT DO NOTHING;