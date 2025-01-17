//
//  ContentView.swift
//  ForkTest
//
//  Created by KyoungJin Baek on 1/17/25.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    // SwiftData를 사용해서 Todo 목록을 가져올게요
    @Query(sort: \Todo.createdAt) private var todos: [Todo]
    @Environment(\.modelContext) private var context

    // 새로운 Todo 입력을 위한 상태 변수예요
    @State private var newTodoTitle = ""

    var body: some View {
        NavigationStack {
            VStack {
                // 새로운 Todo 입력 영역이에요
                HStack {
                    TextField("할 일을 입력해주세요", text: $newTodoTitle)
                        .textFieldStyle(.roundedBorder)

                    Button(action: addTodo) {
                        Image(systemName: "plus.circle.fill")
                            .foregroundStyle(.pink)
                    }
                }
                .padding()

                // Todo 목록을 보여주는 리스트예요
                List {
                    ForEach(todos) { todo in
                        HStack {
                            // 체크박스
                            Button(action: { toggleTodo(todo) }) {
                                Image(
                                    systemName: todo.isCompleted
                                        ? "checkmark.circle.fill" : "circle"
                                )
                                .foregroundStyle(todo.isCompleted ? .green : .gray)
                            }

                            // Todo 제목
                            Text(todo.title)
                                .strikethrough(todo.isCompleted)
                                .foregroundStyle(todo.isCompleted ? .gray : .primary)
                        }
                    }
                    .onDelete(perform: deleteTodos)
                }
            }
            .navigationTitle("✨ Todo List")
        }
    }

    // Todo를 추가하는 함수예요
    private func addTodo() {
        guard !newTodoTitle.isEmpty else { return }

        withAnimation {
            let todo = Todo(title: newTodoTitle)
            context.insert(todo)
            newTodoTitle = ""
        }
    }

    // Todo의 완료 상태를 토글하는 함수예요
    private func toggleTodo(_ todo: Todo) {
        withAnimation {
            todo.isCompleted.toggle()
        }
    }

    // Todo를 삭제하는 함수예요
    private func deleteTodos(at offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                context.delete(todos[index])
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Todo.self)
}
