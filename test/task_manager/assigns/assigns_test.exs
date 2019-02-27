defmodule TaskManager.AssignsTest do
  use TaskManager.DataCase

  alias TaskManager.Assigns

  describe "assigns" do
    alias TaskManager.Assigns.Assign

    @valid_attrs %{time_spent: 42}
    @update_attrs %{time_spent: 43}
    @invalid_attrs %{time_spent: nil}

    def assign_fixture(attrs \\ %{}) do
      {:ok, assign} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Assigns.create_assign()

      assign
    end

    test "list_assigns/0 returns all assigns" do
      assign = assign_fixture()
      assert Assigns.list_assigns() == [assign]
    end

    test "get_assign!/1 returns the assign with given id" do
      assign = assign_fixture()
      assert Assigns.get_assign!(assign.id) == assign
    end

    test "create_assign/1 with valid data creates a assign" do
      assert {:ok, %Assign{} = assign} = Assigns.create_assign(@valid_attrs)
      assert assign.time_spent == 42
    end

    test "create_assign/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Assigns.create_assign(@invalid_attrs)
    end

    test "update_assign/2 with valid data updates the assign" do
      assign = assign_fixture()
      assert {:ok, %Assign{} = assign} = Assigns.update_assign(assign, @update_attrs)
      assert assign.time_spent == 43
    end

    test "update_assign/2 with invalid data returns error changeset" do
      assign = assign_fixture()
      assert {:error, %Ecto.Changeset{}} = Assigns.update_assign(assign, @invalid_attrs)
      assert assign == Assigns.get_assign!(assign.id)
    end

    test "delete_assign/1 deletes the assign" do
      assign = assign_fixture()
      assert {:ok, %Assign{}} = Assigns.delete_assign(assign)
      assert_raise Ecto.NoResultsError, fn -> Assigns.get_assign!(assign.id) end
    end

    test "change_assign/1 returns a assign changeset" do
      assign = assign_fixture()
      assert %Ecto.Changeset{} = Assigns.change_assign(assign)
    end
  end
end
