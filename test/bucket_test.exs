defmodule KV.BucketTest do
    use ExUnit.Case, async: true

    setup do
        # {:ok, bucket} = KV.Bucket.start_link([])
        bucket = start_supervised!(KV.Bucket)
        %{bucket: bucket}
    end


    test "store values by key", %{bucket: bucket} do
        assert KV.Bucket.get(bucket, "milk") == nil


        KV.Bucket.put(bucket, "milk", 3)
        assert KV.Bucket.get(bucket, "milk") == 3
    end

    test "get and delte values", %{bucket: bucket} do
        KV.Bucket.put(bucket, "milk", 3)
        KV.Bucket.put(bucket, "eggs", 2)

        assert 2 == KV.Bucket.delete(bucket, "eggs")
    end

    test "are temporary workers" do
        assert Supervisor.child_spec(KV.Bucket,[]).restart == :temporary
    end

end
