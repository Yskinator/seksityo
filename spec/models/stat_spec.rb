require 'rails_helper'

RSpec.describe Stat, type: :model do
  it "has its values properly initialized to zeroes" do
    stat = Stat.new
    expect(stat.notifications_sent).to eq(0)
    expect(stat.alerts_sent).to eq(0)
    expect(stat.confirmed).to eq(0)
    expect(stat.created).to eq(0)
  end
  it "increments country's first creation stat correctly" do
    Stat.increment_created("123", "spec")
    stat = Stat.find_by_country_code("123")
    expect(stat.created).to eq(1)
  end
  it "increments country's subsequent creation stats correctly" do
    Stat.increment_created("123", "spec")
    Stat.increment_created("123", "spec")
    Stat.increment_created("123", "spec")
    stat = Stat.find_by_country_code("123")
    expect(stat.created).to eq(3)
  end
  it "increments a second country's creation stats correctly" do
    Stat.increment_created("123", "spec")
    Stat.increment_created("124", "spec2")
    stat = Stat.find_by_country_code("124")
    expect(stat.created).to eq(1)
  end
  it "increments country's first confirmation stat correctly" do
    Stat.increment_confirmed("123", "spec")
    stat = Stat.find_by_country_code("123")
    expect(stat.confirmed).to eq(1)
  end
  it "increments country's subsequent confirmation stats correctly" do
    Stat.increment_confirmed("123", "spec")
    Stat.increment_confirmed("123", "spec")
    Stat.increment_confirmed("123", "spec")
    stat = Stat.find_by_country_code("123")
    expect(stat.confirmed).to eq(3)
  end
  it "increments a second country's confirmation stats correctly" do
    Stat.increment_confirmed("123", "spec")
    Stat.increment_confirmed("124", "spec2")
    stat = Stat.find_by_country_code("124")
    expect(stat.confirmed).to eq(1)
  end
  it "increments country's first sent notification stat correctly" do
    Stat.increment_notifications_sent("123", "spec")
    stat = Stat.find_by_country_code("123")
    expect(stat.notifications_sent).to eq(1)
  end
  it "increments country's subsequent sent notifications stats correctly" do
    Stat.increment_notifications_sent("123", "spec")
    Stat.increment_notifications_sent("123", "spec")
    Stat.increment_notifications_sent("123", "spec")
    stat = Stat.find_by_country_code("123")
    expect(stat.notifications_sent).to eq(3)
  end
  it "increments a second country's sent notifications stats correctly" do
    Stat.increment_notifications_sent("123", "spec")
    Stat.increment_notifications_sent("124", "spec2")
    stat = Stat.find_by_country_code("124")
    expect(stat.notifications_sent).to eq(1)
  end
  it "increments country's first sent alerts stat correctly" do
    Stat.increment_alerts_sent("123", "spec")
    stat = Stat.find_by_country_code("123")
    expect(stat.alerts_sent).to eq(1)
  end
  it "increments country's subsequent sent alerts stats correctly" do
    Stat.increment_alerts_sent("123", "spec")
    Stat.increment_alerts_sent("123", "spec")
    Stat.increment_alerts_sent("123", "spec")
    stat = Stat.find_by_country_code("123")
    expect(stat.alerts_sent).to eq(3)
  end
  it "increments a second country's sent alerts stats correctly" do
    Stat.increment_alerts_sent("123", "spec")
    Stat.increment_alerts_sent("124", "spec2")
    stat = Stat.find_by_country_code("124")
    expect(stat.alerts_sent).to eq(1)
  end
end
