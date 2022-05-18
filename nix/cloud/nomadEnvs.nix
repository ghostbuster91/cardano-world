{
  inputs,
  cell,
}: let
  inherit (inputs) data-merge;
  inherit (inputs.bitte-cells) vector;
  inherit (inputs.cells) cardano;
  inherit (cell) constants;

  mkComponents = args: {
  };

  # Components per environment
  # -----------------------------------------------------------------------
  vasil-qa = mkComponents constants.envs.vasil-qa;
  # TODO: pull this from nomadJob?
  persistanceMount = "/persist";
in
  with data-merge; {
    vasil-qa = {
      bft-0 = let
        jobname = "cardano-bft-0";
      in
        merge (
          cardano.nomadJob.default (constants.envs.vasil-qa
            // {
              datacenters = ["eu-central-1"];
              inherit jobname;
            })
        ) {
          job.${jobname}.group.cardano.task.node = {
            # env.ENVIRONMENT = "testnet";
            # env.DEBUG_SLEEP = 6000;
            env.CONSUL_KV_PATH = "config/cardano/vasil-qa";
            env.VAULT_KV_PATH = "kv/data/cardano/vasil-qa/bft-0";
            env.LOCAL_ROOTS_SRV_DNS = "_vasil-qa-${jobname}-node._tcp.service.consul";
            env.PUBLIC_ROOTS_SRV_DNS = "_vasil-qa-node._tcp.service.consul";
          };
        };
      bft-1 = let
        jobname = "cardano-bft-1";
      in
        merge (
          cardano.nomadJob.default (constants.envs.vasil-qa
            // {
              datacenters = ["eu-west-1"];
              inherit jobname;
            })
        ) {
          job.${jobname}.group.cardano.task.node = {
            # env.ENVIRONMENT = "testnet";
            # env.DEBUG_SLEEP = 6000;
            env.DATA_DIR = persistanceMount + "/bft-1";
            env.CONSUL_KV_PATH = "config/cardano/vasil-qa";
            env.VAULT_KV_PATH = "kv/data/cardano/vasil-qa/bft-1";
            env.LOCAL_ROOTS_SRV_DNS = "_vasil-qa-${jobname}-node._tcp.service.consul";
            env.PUBLIC_ROOTS_SRV_DNS = "_vasil-qa-node._tcp.service.consul";
          };
        };
      bft-2 = let
        jobname = "cardano-bft-2";
      in
        merge (
          cardano.nomadJob.default (constants.envs.vasil-qa
            // {
              datacenters = ["us-east-2"];
              inherit jobname;
            })
        ) {
          job.${jobname}.group.cardano.task.node = {
            # env.ENVIRONMENT = "testnet";
            # env.DEBUG_SLEEP = 6000;
            env.CONSUL_KV_PATH = "config/cardano/vasil-qa";
            env.VAULT_KV_PATH = "kv/data/cardano/vasil-qa/bft-2";
            env.LOCAL_ROOTS_SRV_DNS = "_vasil-qa-${jobname}-node._tcp.service.consul";
            env.PUBLIC_ROOTS_SRV_DNS = "_vasil-qa-node._tcp.service.consul";
          };
        };
      sp-1 = let
        jobname = "cardano-sp-1";
      in
        merge (
          cardano.nomadJob.default (
            constants.envs.vasil-qa
            // {
              datacenters = ["eu-west-1"];
              inherit jobname;
            }
          )
        ) {
          job.${jobname}.group.cardano.task.node = {
            # env.ENVIRONMENT = "testnet";
            # env.DEBUG_SLEEP = 6000;
            env.DATA_DIR = persistanceMount + "/sp-1";
            env.CONSUL_KV_PATH = "config/cardano/vasil-qa";
            env.VAULT_KV_PATH = "kv/data/cardano/vasil-qa/sp-1";
            env.LOCAL_ROOTS_SRV_DNS = "_vasil-qa-${jobname}-node._tcp.service.consul";
            env.PUBLIC_ROOTS_SRV_DNS = "_vasil-qa-node._tcp.service.consul";
          };
        };
      sp-2 = let
        jobname = "cardano-sp-2";
      in
        merge (
          cardano.nomadJob.default (
            constants.envs.vasil-qa
            // {
              datacenters = ["us-east-2"];
              inherit jobname;
            }
          )
        ) {
          job.${jobname}.group.cardano.task.node = {
            # env.ENVIRONMENT = "testnet";
            # env.DEBUG_SLEEP = 6000;
            env.DATA_DIR = persistanceMount + "/sp-2";
            env.CONSUL_KV_PATH = "config/cardano/vasil-qa";
            env.VAULT_KV_PATH = "kv/data/cardano/vasil-qa/sp-2";
            env.LOCAL_ROOTS_SRV_DNS = "_vasil-qa-${jobname}-node._tcp.service.consul";
            env.PUBLIC_ROOTS_SRV_DNS = "_vasil-qa-node._tcp.service.consul";
          };
        };
      sp-3 = let
        jobname = "cardano-sp-3";
      in
        merge (
          cardano.nomadJob.default (
            constants.envs.vasil-qa
            // {
              datacenters = ["eu-central-1"];
              inherit jobname;
            }
          )
        ) {
          job.${jobname}.group.cardano.task.node = {
            # env.ENVIRONMENT = "testnet";
            # env.DEBUG_SLEEP = 6000;
            env.DATA_DIR = persistanceMount + "/sp-3";
            env.CONSUL_KV_PATH = "config/cardano/vasil-qa";
            env.VAULT_KV_PATH = "kv/data/cardano/vasil-qa/sp-3";
            env.LOCAL_ROOTS_SRV_DNS = "_vasil-qa-${jobname}-node._tcp.service.consul";
            env.PUBLIC_ROOTS_SRV_DNS = "_vasil-qa-node._tcp.service.consul";
          };
        };
      ogmios-0 = let
        jobname = "ogmios-0";
      in
        merge (cardano.nomadJob.ogmios (
          constants.envs.vasil-qa
          // {
            datacenters = ["us-east-2"];
            inherit jobname;
          }
        )) {
          job.${jobname}.group.ogmios.task = {
            node = {
              # env.ENVIRONMENT = "testnet";
              # env.DEBUG_SLEEP = 6000;
              env.CONSUL_KV_PATH = "config/cardano/vasil-qa";
              env.VAULT_KV_PATH = "kv/data/cardano/vasil-qa/sp-2";
              env.LOCAL_ROOTS_SRV_DNS = "_vasil-qa-${jobname}-node._tcp.service.consul";
              env.PUBLIC_ROOTS_SRV_DNS = "_vasil-qa-node._tcp.service.consul";
            };
            ogmios = {
              # env.ENVIRONMENT = "testnet";
              # env.DEBUG_SLEEP = 6000;
              env.CONSUL_KV_PATH = "config/cardano/vasil-qa";
              env.VAULT_KV_PATH = "kv/data/cardano/vasil-qa/sp-2";
              env.LOCAL_ROOTS_SRV_DNS = "_vasil-qa-${jobname}-node._tcp.service.consul";
              env.PUBLIC_ROOTS_SRV_DNS = "_vasil-qa-node._tcp.service.consul";
            };
          };
        };
    };
  }
