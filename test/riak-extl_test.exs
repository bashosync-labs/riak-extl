defmodule RiakExtlTest do
  use ExUnit.Case, async: false
  #import Mock

  def setup do
    {:ok, doc: true}
  end

  # test "invalid argument: no command" do
  #  assert :ok = RiakExtl.main(["--type", "foo"])
  # end
  # test "invalid argument: sync, no type" do
  #  assert :ok = RiakExtl.main(["sync","--op","--json"])
  # end
  # test "invalid argument: create_indexes, no type" do
  #  assert :ok = RiakExtl.main(["create_indexes","--op"])
  # end
  # test "help" do
  #  assert :ok = RiakExtl.main(["help"])
  # end
  # test "ping" do
  #   assert :ok = RiakExtl.main(["ping"])
  # end
  # test "sync, no-op, json validation" do
  #   assert :ok = RiakExtl.main(["--type", "consistent", "sync","--no-op","--json"])
  # end
  # test "sync, no-op, no json validation" do
  #   assert :ok = RiakExtl.main(["--type", "consistent", "sync","--no-op","--no-json"])
  # end
  # test "sync, op, json validation" do
  #   assert :ok = RiakExtl.main(["--type","consistent","sync","--op","--json"])
  # end
  # test "create_indexes, no-op" do
  #   assert :ok = RiakExtl.main(["--type","search","create_indexes","--no-op"])
  # end
  # test "sync_indexes, op" do
  #   assert :ok = RiakExtl.main(["--type","search","sync_indexes","--op"])
  # end
  # test "list_src_buckets" do
  #   assert :ok = RiakExtl.main(["--type","consistent","list_src_buckets"])
  # end
  # test "list_sink_buckets" do
  #   assert :ok = RiakExtl.main(["--type","consistent","list_sink_buckets"])
  # end
  #

  test "sync (consistent), no-op, json validation" do
    assert :ok = RiakExtl.main(["--type", "consistent", "sync","--no-op","--json"])
  end

  test "sync_indexes, no-op, json validation" do
    assert :ok = RiakExtl.main(["--type", "search", "sync_indexes","--no-op","--json"])
  end

  test "sync (search), no-op, json validation" do
    assert :ok = RiakExtl.main(["--type", "search", "sync","--no-op","--json"])
  end

  test "sync_to_fs (consistent), op, no json validation" do
    assert :ok = RiakExtl.main(["--type", "consistent", "sync_to_fs","--op","--no-json"])
  end

  test "sync_indexes_to_fs, op, no json validation" do
    assert :ok = RiakExtl.main(["--type", "search", "sync_indexes_to_fs","--op","--no-json"])
  end

  test "sync_to_fs (search), op, no json validation" do
    assert :ok = RiakExtl.main(["--type", "search", "sync_to_fs","--op","--no-json"])
  end

  test "sync_from_fs (consistent), op, no json validation" do
    assert :ok = RiakExtl.main(["--type", "consistent", "sync_from_fs","--op","--no-json"])
  end

  test "sync_indexes_from_fs, op, no json validation" do
    assert :ok = RiakExtl.main(["--type", "search", "sync_indexes_from_fs","--op","--no-json"])
  end

  test "sync_from_fs (search), op, no json validation" do
    assert :ok = RiakExtl.main(["--type", "search", "sync_from_fs","--op","--no-json"])
  end

  test "sync (consistent) 2, no-op, json validation" do
    assert :ok = RiakExtl.main(["--type", "consistent", "sync","--no-op","--json"])
  end

  test "sync_indexes 2, no-op, json validation" do
    assert :ok = RiakExtl.main(["--type", "search", "sync_indexes","--no-op","--json"])
  end

  test "sync, no-op 2, json validation" do
    assert :ok = RiakExtl.main(["--type", "search", "sync","--no-op","--json"])
  end

  #
  # test_with_mock "start/register/ping riak", Riak.Connection, [start: fn( _ip, _port ) ->
  #     Agent.start_link fn -> [] end
  #   end ] do
  # test "Start Riak" do
  #   assert :ok = RiakExtl.Store.start_riak(:start_test, "127.0.0.1", 10018)
  #   assert is_pid(Process.whereis(:start_test))
  #   assert is_pid(RiakExtl.Store.riak_pid(:start_test))
  #   assert_raise RuntimeError, fn ->
  #     RiakExtl.Store.riak_pid(:unknown)
  #   end
  # end
  # test ""
  #   assert_raise RuntimeError, fn ->
  #     pid = spawn fn -> Process.register(self(), :test) end
  #     with_mock Process, [whereis: fn(_name) -> pid end, alive?: fn(_pid) -> false end ] do
  #       refute pid == RiakExtl.Store.riak_pid(:test)
  #     end
  #   end
  #   with_mock Riak, [ping: fn(_pid) -> :pong end] do
  #     assert :pong = RiakExtl.Store.riak_ping(:start_test)
  #   end
  #
  #
  #   with_mock Riak.Bucket.Type, [list!: fn(_pid, type) -> ["#{type}_bucket_1", "#{type}_bucket_2", "#{type}_bucket_3"] end] do
  #     with_mock Riak.Bucket, [
  #       keys!: fn(pid, {_type, _bucket}) ->
  #         case ( Process.whereis(:src) == pid or test_same ) do
  #           true -> ["fookey1", "fookey2", "fookey3"]
  #           false -> []
  #         end
  #       end,
  #       put: fn(_pid, {_t,_b}, _p) -> :ok end,
  #       get: fn(pid, {_t,b}) ->
  #         case ( Process.whereis(:src) == pid or test_same ) do
  #           true -> {:ok, [n_val: 3, search_index: b ]}
  #           false -> {:ok, []}
  #         end
  #       end
  #       ] do
  #         with_mock Riak.Search.Index, [
  #           get: fn(pid, idx_name) ->
  #           case ( Process.whereis(:src) == pid or test_same ) do
  #               true -> {:ok, [index: idx_name, schema: idx_name]}
  #               false -> {:error, "notfound"}
  #             end
  #           end,
  #           put: fn(_pid, _idx, _schema, _props) -> :ok end
  #         ] do
  #         with_mock Riak.Search.Schema, [
  #           create: fn(_pid, _schema, _schema_xml) -> :ok end,
  #           get: fn(pid, schema) ->
  #             case ( Process.whereis(:src) == pid or test_same ) do
  #               true -> {:ok, [name: schema, content: "<xml></xml>"]}
  #               false -> {:error, "notfound"}
  #             end
  #           end
  #           ] do
  #           with_mock Riak, [
  #             delete: fn(_pid, _obj) -> :ok end,
  #             find: fn(pid, {type, bucket}, key) ->
  #               case ( Process.whereis(:src) == pid or test_same ) do
  #                 true ->
  #                   Riak.Object.create(bucket: bucket, type: type, key: key, data: "{}")
  #                 false -> nil
  #               end
  #             end,
  #             put: fn(_pid, _obj) -> :ok end,
  #             ping: fn(_pid) -> :pong end
  #           ] do
  #             with_mock Logger, [
  #                 configure_backend: fn(_,_) -> :ok end,
  #                 add_backend: fn(_) -> :ok end,
  #                 log: fn(a1,a2,a3) -> IO.inspect([a1, a2, a3]); :ok end
  #               ] do
  #               assert :ok = RiakExtl.main([])
  #               Process.unregister(:config)
  #                assert :ok = RiakExtl.main(["--type", "foo"])
  # #               Process.unregister(:config)
  #                assert :ok = RiakExtl.main(["help"])
  # #               Process.unregister(:config)
  # #
  #               assert :ok = RiakExtl.main(["ping"])
  # #               Process.unregister(:src)
  # #               Process.unregister(:sink)
  # #               Process.unregister(:config)
  # #
  #                assert :ok = RiakExtl.main(["sync","--op","--json"])
  #               Process.unregister(:config)
  #
  #               assert :ok = RiakExtl.main(["--type","foo","sync","--op","--json"])
  #               Process.unregister(:src)
  #               Process.unregister(:sink)
  #               Process.unregister(:config)
  #
  #
  #               assert :ok = RiakExtl.main(["create_indexes","--op","--json"])
  #               Process.unregister(:config)
  #               assert :ok = RiakExtl.main(["--type","foo","create_indexes","--op","--json"])
  #               Process.unregister(:src)
  #               Process.unregister(:sink)
  #               Process.unregister(:config)
  #               assert :ok = RiakExtl.main(["list_src_buckets","--op","--json"])
  #               Process.unregister(:config)
  #               assert :ok = RiakExtl.main(["list_sink_buckets","--op","--json"])
  #               Process.unregister(:config)
  #               assert :ok = RiakExtl.main(["--type","foo","list_src_buckets","--op","--json"])
  #               #Process.unregister(:src)
  #               Process.unregister(:config)
  #               assert :ok = RiakExtl.main(["--type","foo","list_sink_buckets","--op","--json"])
  #               #Process.unregister(:sink)
  #               #Process.unregister(:config)
  #
  #               assert :ok = RiakExtl.Config.config(:test, "value")
  #               assert "value" = RiakExtl.Config.config :test
  #
  #               RiakExtl.Config.config(:type, "foo")
  #               RiakExtl.Config.config(:test_same, true)
  #
  #               buckets = RiakExtl.Store.get_buckets!(:src, "foo")
  #               assert buckets = ["foo_bucket_1", "foo_bucket_2", "foo_bucket_3"]
  #
  #               assert :ok = RiakExtl.print_buckets(:src)
  #
  #               keys = RiakExtl.Store.get_keys!(:src,"foo","foo_bucket_1")
  #               assert keys = ["fookey1", "fookey2", "fookey3"]
  #
  #               obj = RiakExtl.Store.get_obj!(:src,"foo","foo_bucket_1","fookey1")
  #               assert obj == Riak.Object.create(bucket: "foo_bucket_1", type: "foo", key: "fookey1", data: "{}")
  #
  #
  #               RiakExtl.Config.config(:op, false)
  #               RiakExtl.Config.config(:json, false)
  #               assert :ok = RiakExtl.Store.put_obj!(:src, obj)
  #               assert :ok = RiakExtl.Store.del_obj!(:src, obj)
  #
  #               assert {:src, "foo", [], "foo_schema_1", "<xml></xml>"} = RiakExtl.get_schema({:src,"foo",[],"foo_schema_1"})
  #               assert :ok = RiakExtl.Store.put_schema(:src, "foo_schema_1", "<xml></xml>")
  #
  #               assert :ok = RiakExtl.migrate_type
  #               assert :ok = RiakExtl.migrate_type_create_indexes
  #
  #               RiakExtl.Config.config(:op, true)
  #               assert :ok = RiakExtl.Store.put_obj!(:src, obj)
  #               assert :ok = RiakExtl.Store.del_obj!(:src, obj)
  #
  #               RiakExtl.Config.config(:json, true)
  #               assert :ok = RiakExtl.Store.put_obj!(:src, obj)
  #               # should fail to put, should test to be sure of this
  #               obj = %{obj | data: ""}
  #               assert :ok = RiakExtl.Store.put_obj!(:src, obj)
  #               # should fail to put, should test to be sure of this
  #               obj = %{obj | data: "]"}
  #               assert :ok = RiakExtl.Store.put_obj!(:src, obj)
  #
  #               assert :ok = RiakExtl.Store.put_schema(:src, "foo_schema_1", "<xml></xml>")
  #
  #               assert :ok = RiakExtl.migrate_type
  #               assert :ok = RiakExtl.migrate_type_create_indexes
  #
  #               RiakExtl.Config.config(:test_same, false)
  #               assert :ok = RiakExtl.migrate_type
  #               assert :ok = RiakExtl.migrate_type_create_indexes
  #
  #               end
  #             end
  #           end
  #         end
  #       end
  #     end
  # end
end
