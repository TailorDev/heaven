require "spec_helper"

describe Heaven::Provider::Fabric do
  include FixtureHelper

  let(:deployment) { Heaven::Provider::Fabric.new(SecureRandom.uuid, decoded_fixture_data("deployment-capistrano")) }

  it "finds deployment task and strips 'deploy:'" do
    expect(deployment.task).to eql "migrations"
  end
end
