defmodule TaskManager2Web.AssignControllerTest do
  use TaskManager2Web.ConnCase

  alias TaskManager2.Assigns

  @create_attrs %{time_spent: 42}
  @update_attrs %{time_spent: 43}
  @invalid_attrs %{time_spent: nil}

  def fixture(:assign) do
    {:ok, assign} = Assigns.create_assign(@create_attrs)
    assign
  end

  describe "index" do
    test "lists all assigns", %{conn: conn} do
      conn = get(conn, Routes.assign_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Assigns"
    end
  end

  describe "new assign" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.assign_path(conn, :new))
      assert html_response(conn, 200) =~ "New Assign"
    end
  end

  describe "create assign" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.assign_path(conn, :create), assign: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.assign_path(conn, :show, id)

      conn = get(conn, Routes.assign_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Assign"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.assign_path(conn, :create), assign: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Assign"
    end
  end

  describe "edit assign" do
    setup [:create_assign]

    test "renders form for editing chosen assign", %{conn: conn, assign: assign} do
      conn = get(conn, Routes.assign_path(conn, :edit, assign))
      assert html_response(conn, 200) =~ "Edit Assign"
    end
  end

  describe "update assign" do
    setup [:create_assign]

    test "redirects when data is valid", %{conn: conn, assign: assign} do
      conn = put(conn, Routes.assign_path(conn, :update, assign), assign: @update_attrs)
      assert redirected_to(conn) == Routes.assign_path(conn, :show, assign)

      conn = get(conn, Routes.assign_path(conn, :show, assign))
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, assign: assign} do
      conn = put(conn, Routes.assign_path(conn, :update, assign), assign: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Assign"
    end
  end

  describe "delete assign" do
    setup [:create_assign]

    test "deletes chosen assign", %{conn: conn, assign: assign} do
      conn = delete(conn, Routes.assign_path(conn, :delete, assign))
      assert redirected_to(conn) == Routes.assign_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.assign_path(conn, :show, assign))
      end
    end
  end

  defp create_assign(_) do
    assign = fixture(:assign)
    {:ok, assign: assign}
  end
end
