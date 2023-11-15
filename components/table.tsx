import prisma from "@/lib/prisma";
import { timeAgo } from "@/lib/utils";
import RefreshButton from "./refresh-button";

export default async function Table() {
  // Use lowercase 'users' for the variable name to avoid confusion with the 'User' model
  const users = await prisma.user.findMany(); // Model names are PascalCase in Prisma

  return (
    <div className="bg-white/30 p-12 shadow-xl ring-1 ring-gray-900/5 rounded-lg backdrop-blur-lg max-w-xl mx-auto w-full">
      <div className="flex justify-between items-center mb-4">
        <div className="space-y-1">
          <h2 className="text-xl font-semibold">Recent Users</h2>
          <p className="text-sm text-gray-500"></p>
        </div>
        <RefreshButton />
      </div>
      <div className="divide-y divide-gray-900/5">
        {users.map(
          (
            user // Use lowercase 'user' for the variable in the map function
          ) => (
            <div
              key={user.id} // It's better to use the 'id' as the key since it's unique
              className="flex items-center justify-between py-3"
            >
              <div className="flex items-center space-x-4">
                <div className="space-y-1">
                  <p className="font-medium leading-none">{user.name}</p>
                  <p className="text-sm text-gray-500">{user.email}</p>
                </div>
              </div>
              <p className="text-sm text-gray-500">{timeAgo(user.createdAt)}</p>
            </div>
          )
        )}
      </div>
    </div>
  );
}
